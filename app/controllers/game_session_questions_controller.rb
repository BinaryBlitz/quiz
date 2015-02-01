class GameSessionQuestionsController < ApplicationController
  def show
    @game_session_question = GameSessionQuestion.find(params[:id])
    render json: @game_session_question
  end

  def update
    @game_session_question = GameSessionQuestion.find(params[:id])
    if current_player == @game_session_question.game_session.host
      @game_session_question.host_answer_id = params[:game_session_question][:answer_id]
      @game_session_question.host_time = params[:game_session_question][:time]
    elsif current_player == @game_session_question.game_session.opponent
      @game_session_question.opponent_answer_id = params[:game_session_question][:answer_id]
      @game_session_question.opponent_time = params[:game_session_question][:time]
    end

    if @game_session_question.save
      push_answer
      head :no_content
    else
      render json: @game_session_question.errors, status: :unprocessable_entity
    end
  end

  private

  def push_answer
    current_session = @game_session_question.game_session
    # If host updated answer, send data to opponent
    if @current_player == current_session.host
      Pusher.trigger(
        "player-session-#{current_session.opponent_id}",
        'opponent-answer',
        answer_data(
          @game_session_question.id,
          @game_session_question.host_answer_id,
          @game_session_question.host_time)
        )
    elsif @current_player == current_session.opponent
      Pusher.trigger(
        "player-session-#{current_session.host_id}",
        'opponent-answer',
        answer_data(
          @game_session_question.id,
          @game_session_question.opponent_answer_id,
          @game_session_question.opponent_time))
    end
  end

  def answer_data(session_question_id, answer_id, answer_time)
    { game_session_question_id: session_question_id, answer_id: answer_id, answer_time: answer_time }
  end

  def game_session_question_params
    params.require(:game_session_question)
      .permit(:host_answer_id, :host_time, :answer_id, :time)
  end
end
