# == Schema Information
#
# Table name: room_questions
#
#  id              :integer          not null, primary key
#  room_session_id :integer
#  question_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class RoomQuestion < ActiveRecord::Base
  belongs_to :room_session
  belongs_to :question

  has_many :room_answers, dependent: :destroy

  validates :room_session, presence: true
  validates :question, presence: true

  def answer(answer_params)
    answer = room_answers.build(answer_params)
    notify_new_answer(answer) if answer.valid?
    answer
  end

  def question_results
    result = {}
    room_answers.each { |answer| result[answer.player] = answer.points }
    result
  end

  private

  # New answer notification
  def notify_new_answer(answer)
    Pusher.trigger("room-#{room_session.room.id}", 'new-answer', answer.as_json)
    logger.debug "#{Time.zone.now}: New answer notification sent to room \##{room_session.room.id}"
  end
end
