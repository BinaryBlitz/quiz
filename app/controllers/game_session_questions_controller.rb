class GameSessionQuestionsController < ApplicationController
  before_action :restrict_access

  def show
    @game_session_question = GameSessionQuestion.find(params[:id])
    render json: @game_session_question
  end

  def update
    @game_session_question = GameSessionQuestion.find(params[:id])

    if @game_session_question.update(game_session_question_params)
      head :no_content
    else
      render json: @game_session_question.errors, status: :unprocessable_entity
    end
  end

  private

  def game_session_question_params
    params.require(:game_session_question).permit(:player_points, :opponent_points)
  end
end
