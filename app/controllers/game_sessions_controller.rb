class GameSessionsController < ApplicationController
  before_action :find_game_session, only: [:show, :update, :destroy, :close]
  before_action :update_stats, only: [:close]
  # GET /game_sessions
  def index
    @game_sessions = GameSession.all
    render formats: :json
  end

  # GET /game_sessions/1
  def show
    render formats: :json
  end

  # POST /game_sessions
  def create
    @game_session = GameSession.new(game_session_params)

    if @game_session.save
      render :show, formats: :json, status: :created, location: @game_session
    else
      render json: @game_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH /game_sessions/1
  def update
    if @game_session.update(game_session_params)
      head :no_content
    else
      render json: @game_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /game_sessions/1
  def destroy
    @game_session.destroy

    head :no_content
  end

  # PATCH /game_sessions/1/close
  def close
    @game_session.update!(closed: true, finisher: current_player)
    current_player.topic_results
      .find_or_create_by(topic: @game_session.topic)
      .add(@game_session.player_points(current_player))
    head :no_content
  end

  private

  def game_session_params
    params.require(:game_session).permit(:host_id, :opponent_id, :topic_id)
  end

  def find_game_session
    @game_session = GameSession.find(params[:id])
  end

  def update_stats
    current_player.stats.increment_consecutive_days
    current_player.stats.increment_early_winner(@game_session)
  end
end
