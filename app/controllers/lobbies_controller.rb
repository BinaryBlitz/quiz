class LobbiesController < ApplicationController
  before_action :restrict_access
  before_action :find_lobby, only: [:show, :find]

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

  # TODO
  def find
    # Check if session was already created
    sessions = @current_player.game_sessions
    if sessions.any? && !sessions.last.finished?
      session = @current_player.game_sessions.last
      render partial: 'game_sessions/game_session',
             locals: { game_session: session }
      return
    end

    # Don't search if closed
    if @lobby.closed?
      render json: 'Lobby is closed.'
      return
    else
      opponent_lobby = @lobby.find_opponent_lobby
      if opponent_lobby
        @session = GameSession.create(topic: @lobby.topic,
                                      host: @current_player,
                                      opponent: opponent_lobby.player,
                                      offline: false)
        @session.generate
        @lobby.close
      else
        if @lobby.query_count >= Lobby::MAX_QUERY_COUNT
          @session = GameSession.create(topic: @lobby.topic,
                                        host: @current_player,
                                        offline: true)
          @session.generate
          @lobby.close
        else
          @lobby.increment_count
          render json: 'Opponent not found, try again.'
          return
        end
      end
    end

    render formats: :json
  end

  private

  def find_lobby
    @lobby = Lobby.find(params[:id])
  end

  def lobby_params
    params.require(:lobby).permit(:topic_id)
  end
end
