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

  def question_results
    result = Hash.new
    room_answers.each { |answer| result[answer.player] = answer.points }
    result
  end

  def answer(new_answer, time)
    room_answers.create(answer: new_answer, time: time)
  end
end

