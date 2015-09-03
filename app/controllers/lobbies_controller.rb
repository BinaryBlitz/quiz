class LobbiesController < ApplicationController
  before_action :restrict_access
  before_action :find_lobby,
                only: [:show, :find, :destroy, :close, :accept_challenge, :decline_challenge]

  include LobbySessions

  # POST /lobbies
  def create
    @lobby = Lobby.new(lobby_params)
    @lobby.player = current_player

    if @lobby.save
      logger.debug "Player #{current_player.id} created a lobby."
      render :show, status: :created
    else
      render json: @lobby.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @lobby.destroy
    head :no_content
  end

  def challenges
    @lobbies = current_player.challenges
  end

  def challenged
    @lobbies = current_player.challenged
  end

  # 1. Create the lobby with the given opponent and topic
  # 2. Create the session
  # 3. Push the challenge to opponent (with lobby id)
  # 4. Opponent accepts the challenge, closes the lobby, receives the session, pushes game start
  # 5. The game either starts, or the host is playing delayed session
  def challenge
    opponent = Player.find(params[:opponent_id])
    topic = Topic.find(params[:topic_id])

    lobby = current_player.lobbies.build(topic: topic).challenge_player(opponent)
    @game_session = lobby.game_session
    render 'game_sessions/show'
  end

  def accept_challenge
    # Close the lobby
    head :unprocessable_entity and return if @lobby.closed?
    @lobby.close

    # Render and start the game
    render partial: 'game_sessions/game_session', locals: { game_session: @lobby.game_session }
    PusherSender.new(current_player.id, @lobby.game_session.host_id).start_game
  end

  def decline_challenge
    if lobby.closed?
      head :unprocessable_entity
    else
      @lobby.decline_challenge
      head :no_content
    end
  end

  # GET /lobbies/1/find
  def find
    # Don't search if closed
    render json: 'Lobby is closed.', status: :unprocessable_entity and return if @lobby.closed?

    # Check if session was already created
    if @lobby.game_session
      logger.debug 'Game session found. Starting.'
      @lobby.close
      render_lobby_session
      PusherSender.new(current_player.id, @lobby.game_session.host_id).start_game
      return
    end

    # Find opponent lobby, otherwise increment count or create offline session
    opponent_lobby = @lobby.find_opponent_lobby
    if opponent_lobby
      logger.debug 'Lobby found. Creating game session.'
      create_online_session_with_lobby(opponent_lobby)
    else
      logger.debug "Lobby not found. Attempt #{@lobby.query_count}."
      increment_lobby and return if @lobby.query_count < Lobby::MAX_QUERY_COUNT
      logger.debug 'Creating offline session.'
      create_offline_session
    end
  end

  # PATCH /lobbies/1/close
  def close
    @lobby.close
    head :no_content
  end

  private

  # Render session if already exists
  def render_lobby_session
    @session = @lobby.game_session
    render formats: :json
  end

  # Increment lobby count and render message
  def increment_lobby
    @lobby.increment_count
    render json: 'Opponent not found, try again.'
  end

  def find_lobby
    @lobby = Lobby.find(params[:id])
  end

  def lobby_params
    params.require(:lobby).permit(:topic_id)
  end
end
