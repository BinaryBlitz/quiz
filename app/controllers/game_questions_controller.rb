class GameQuestionsController < ApplicationController
  before_action :find_game_question
  before_action :find_current_session

  # PATCH /game_question/1
  def update
    # TODO: Deprecate
    params[:game_question] = params[:game_session_question] if params[:game_session_question].present?

    answer_id = params[:game_question][:answer_id].to_i
    time = params[:game_question][:time].to_i

    update_answer(answer_id, time)
    if @game_question.save
      head :no_content
    else
      render json: @game_question.errors, status: :unprocessable_entity
    end
  end

  private

  # Update answer data (host / opponent)
  def update_answer(answer_id, time)
    if current_player == @current_session.host
      update_host_answer(answer_id, time)
      push_answer(@current_session.opponent, answer_id, time) unless @current_session.offline?
    elsif current_player == @current_session.opponent
      update_opponent_answer(answer_id, time)
      push_answer(@current_session.host, answer_id, time) unless @current_session.offline?
    end
  end

  # Push to host
  def update_host_answer(answer_id, time)
    @game_question.host_answer_id = answer_id
    @game_question.host_time = time
  end

  # Push to opponent
  def update_opponent_answer(answer_id, time)
    @game_question.opponent_answer_id = answer_id
    @game_question.opponent_time = time
  end

  # Push player answer to opponent
  def push_answer(player, answer_id, time)
    logger.debug "#{Time.zone.now}: Started sending answer to #{player.username}."
    Pusher.trigger(
      "player-session-#{player.id}",
      'opponent-answer',
      answer_data(answer_id, time)
    )
    logger.debug "#{Time.zone.now}: Answer to #{player.username} has been sent."
  end

  # Format data for pusher
  def answer_data(answer_id, answer_time)
    {
      game_session_question_id: @game_question.id,
      answer_id: answer_id,
      answer_time: answer_time
    }
  end

  def find_game_question
    @game_question = GameQuestion.find(params[:id])
  end

  def find_current_session
    @current_session = @game_question.game_session
  end

  def game_session_question_params
    params.require(:game_question).permit(:host_answer_id, :host_time, :answer_id, :time)
  end
end
