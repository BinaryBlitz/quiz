class LobbiesController < ApplicationController
  before_action :restrict_access
  before_action :find_lobby, only: [:show, :find, :close, :accept_challenge, :decline_challenge]

  # POST /lobbies
  def create
    @lobby = Lobby.new(lobby_params)
    @lobby.player = current_player

    if @lobby.save
      logger.debug "Player #{current_player.id} created a lobby."
      render :show, formats: :json, status: :created
    else
      render json: @lobby.errors, status: :unprocessable_entity
    end
  end

  def challenges
    @lobbies = Lobby.joins(:game_session)
                    .where(game_sessions: { opponent_id: current_player.id })
                    .where(closed: false)
  end

  def challenged
    @lobbies = current_player.lobbies.where(challenge: true).where(closed: false)
  end

  # 1. Create the lobby with the given opponent ant topic
  # 2. Create the session
  # 3. Push the challenge to opponent (with lobby id)
  # 4. Opponent accepts the challenge, closes the lobby, receives the session, pushes game start
  # 5. The game either starts, or the host is playing delayed session
  def challenge
    opponent = Player.find(params[:opponent_id])
    topic = Topic.find(params[:topic_id])

    @lobby = Lobby.new(player: current_player, topic: topic, challenge: true)
    @lobby.generate_session(opponent)

    push_challenge(opponent)
    render partial: 'game_sessions/game_session', locals: { game_session: @lobby.game_session }
  end

  def accept_challenge
    # Close the lobby
    head :unprocessable_entity and return if @lobby.closed?
    @lobby.close

    # Render and start the game
    render partial: 'game_sessions/game_session', locals: { game_session: @lobby.game_session }
    start_game
  end

  def decline_challenge
    # Close the lobby
    head :unprocessable_entity and return if @lobby.closed?
    @lobby.close
    logger.debug "#{current_player} declined the challenge of #{@lobby.game_session.host}."

    # Notify host
    Pusher.trigger("player-session-#{@lobby.game_session.host.id}", 'challenge-declined', {})
    push_decline

    head :no_content
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
      start_game
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
    Pusher.trigger("player-session-#{current_player.id}", 'game-start', {})
    logger.debug "Game start event sent to player #{current_player.id}."
    Pusher.trigger("player-session-#{@lobby.game_session.host_id}", 'game-start', {})
    logger.debug "Game start event sent to player #{@lobby.game_session.host_id}."
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
      host: current_player,
      opponent: opponent_lobby.player,
      offline: false)
    @session.lobbies << [@lobby, opponent_lobby]
    @lobby.close
  end

  # Opponent not found, create offline session with given params
  def create_offline_session
    @session = GameSession.create!(
      topic: @lobby.topic,
      host: current_player,
      offline: true)
    @lobby.close
  end

  def push_challenge(opponent)
    message = "#{current_player} challenged you."
    options = { action: 'CHALLENGE', lobby: { id: @lobby.id } }
    opponent.push_notification(message, options)
  end

  def push_decline
    message = "#{current_player} has declined the challenge."
    options = { action: 'CHALLENGE_DECLINED', lobby: { id: @lobby.id } }
    @lobby.player.push_notification(message, options)
  end

  def find_lobby
    @lobby = Lobby.find(params[:id])
  end

  def lobby_params
    params.require(:lobby).permit(:topic_id)
  end
end
