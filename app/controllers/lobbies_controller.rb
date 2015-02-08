class LobbiesController < ApplicationController
  before_action :restrict_access
  before_action :find_lobby, only: [:show, :find, :close]

  # POST /lobbies
  def create
    @lobby = Lobby.new(lobby_params)
    @lobby.player = @current_player

    if @lobby.save
      render :show, formats: :json, status: :created, location: @lobby
    else
      render json: @lobby.errors, status: :unprocessable_entity
    end
  end

  # GET /lobbies/1/find
  def find
    # Don't search if closed
    render json: 'Lobby is closed.', status: :unprocessable_entity and return if @lobby.closed?

    # Check if session was already created
    if @lobby.game_session
      @lobby.close
      render_lobby_session
      start_game
      return
    end

    # Find opponent lobby, otherwise increment count or create offline session
    opponent_lobby = @lobby.find_opponent_lobby
    if opponent_lobby
      create_online_session_with_lobby(opponent_lobby)
    else
      increment_lobby and return if @lobby.query_count < Lobby::MAX_QUERY_COUNT
      create_offline_session
    end

    render formats: :json
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

  # Trigger Pusher events
  def start_game
    Pusher.trigger("player-session-#{@current_player.id}", 'game-start', {})
    Pusher.trigger("player-session-#{@lobby.game_session.host_id}", 'game-start', {})
  end

  # Increment lobby count and render message
  def increment_lobby
    @lobby.increment_count
    render json: 'Opponent not found, try again.'
  end

  # Opponent found, create online session
  def create_online_session_with_lobby(opponent_lobby)
    @session = GameSession.create!(
      topic: @lobby.topic,
      host: @current_player,
      opponent: opponent_lobby.player,
      offline: false)
    @session.lobbies << [@lobby, opponent_lobby]
    @lobby.close
  end

  # Opponent not found, create offline session with given params
  def create_offline_session
    @session = GameSession.create!(
      topic: @lobby.topic,
      host: @current_player,
      offline: true)
    @lobby.close
  end

  def find_lobby
    @lobby = Lobby.find(params[:id])
  end

  def lobby_params
    params.require(:lobby).permit(:topic_id)
  end
end
