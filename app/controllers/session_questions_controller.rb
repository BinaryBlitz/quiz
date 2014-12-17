class SessionQuestionsController < ApplicationController
  def show
    @session_question = SessionQuestion.find(params[:id])
    render json: @session_question
  end

  def update
    @session_question = SessionQuestion.find(params[:id])

    if @session_question.update(session_question_params)
      head :no_content
    else
      render json: @session_question.errors, status: :unprocessable_entity
    end
  end

  private

  def session_question_params
    params.require(:session_question).permit(:player_points, :opponent_points)
  end
end