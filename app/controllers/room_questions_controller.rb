class RoomQuestionsController < ApplicationController
  before_action :set_room_question, only: [:answer]

  def answer
    room_answer = @room_question.answer(room_answer_params.merge(player: current_player))

    if room_answer.save
      head :created
    else
      render json: room_answer.errors, status: :unprocessable_entity
    end
  end

  private

  def set_room_question
    @room_question = RoomQuestion.find(params[:id])
  end

  def room_answer_params
    params.require(:room_answer).permit(:answer_id, :time)
  end
end
