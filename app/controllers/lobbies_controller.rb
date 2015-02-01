class LobbiesController < ApplicationController
  before_action :restrict_access
  before_action :find_lobby, only: [:show, :find, :close]

  def show
    @lobby.update(query_count: @lobby.query_count + 1)
    render formats: :json
  end

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

  def find
    # Don't search if closed
    render json: 'Lobby is closed.', status: :unprocessable_entity and return if @lobby.closed?

    # Check if session was already created
    if @lobby.game_session
      close_lobby
      render_lobby_session
      return
    end

    opponent_lobby = @lobby.find_opponent_lobby
    if opponent_lobby
      create_online_session_with_lobby(opponent_lobby)
    else
      increment_lobby and return if @lobby.query_count < Lobby::MAX_QUERY_COUNT
      create_offline_session
    end

    render formats: :json
  end

  def close
    @lobby.close
    head :no_content
  end

  private

  def find_lobby
    @lobby = Lobby.find(params[:id])
  end

  def lobby_params
    params.require(:lobby).permit(:topic_id)
  end

  def render_lobby_session
    @session = @lobby.game_session
    render formats: :json
    start_game
  end

  def start_game
    Pusher.trigger("player-session-#{@current_player.id}", 'game-start', {})
    Pusher.trigger("player-session-#{@lobby.game_session.host_id}", 'game-start', {})
  end

  def increment_lobby
    @lobby.increment_count
    render json: 'Opponent not found, try again.'
  end

  def create_online_session_with_lobby(opponent_lobby)
    @session = GameSession.create(
      topic: @lobby.topic,
      host: @current_player,
      opponent: opponent_lobby.player,
      offline: false)
    @lobby.game_session = @session
    opponent_lobby.update(game_session: @session)
    close_lobby
  end

  def create_offline_session
    @session = GameSession.create(
      topic: @lobby.topic,
      host: @current_player,
      offline: true)
    close_lobby
  end

  def close_lobby
    @lobby.close
  end
end
