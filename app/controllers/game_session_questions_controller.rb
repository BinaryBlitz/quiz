class GameSessionQuestionsController < ApplicationController
  before_action :find_session_question, only: [:show, :update]

  # PATCH /game_session_question/1
  def update
    @current_session = @session_question.game_session
    answer_id = params[:game_session_question][:answer_id]
    time = params[:game_session_question][:time]

    update_answer(answer_id, time)
    if @session_question.save
      head :no_content
    else
      render json: @session_question.errors, status: :unprocessable_entity
    end
  end

  private

  # Update answer data (host / opponent)
  def update_answer(answer_id, time)
    if current_player == @current_session.host
      update_host_answer(answer_id, time)
      push_answer(@current_session.opponent, answer_id, time)
    elsif current_player == @current_session.opponent
      update_opponent_answer(answer_id, time)
      push_answer(@current_session.host, answer_id, time)
    end
  end

  # Push to host
  def update_host_answer(answer_id, time)
    @session_question.host_answer_id = answer_id
    @session_question.host_time = time
  end

  # Push to opponent
  def update_opponent_answer(answer_id, time)
    @session_question.opponent_answer_id = answer_id
    @session_question.opponent_time = time
  end

  # Push player answer to opponent
  def push_answer(player, answer_id, time)
    Pusher.trigger(
      "player-session-#{player.id}",
      'opponent-answer',
      answer_data(answer_id, time)
    )
  end

  # Format data for pusher
  def answer_data(answer_id, answer_time)
    {
      game_session_question_id: @session_question.id,
      answer_id: answer_id,
      answer_time: answer_time
    }
  end

  def find_session_question
    @session_question = GameSessionQuestion.find(params[:id])
  end

  def game_session_question_params
    params.require(:game_session_question)
      .permit(:host_answer_id, :host_time, :answer_id, :time)
  end
end
