class GameSessionsController < ApplicationController
  before_action :set_game_session, except: [:index]

  # GET /game_sessions/1
  def show
  end

  def update
    if @game_session.update(game_session_params)
      head :ok
    else
      render json: @game_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH /game_sessions/1/close
  def close
    @game_session.close(current_player)
    head :no_content
  end

  private

  def game_session_params
    params.require(:game_session).permit(:host_id, :opponent_id, :topic_id, :offline)
  end

  def set_game_session
    @game_session = GameSession.find(params[:id])
  end
end
