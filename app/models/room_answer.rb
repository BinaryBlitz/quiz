# == Schema Information
#
# Table name: room_answers
#
#  id               :integer          not null, primary key
#  room_question_id :integer
#  player_id        :integer
#  time             :integer
#  answer_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class RoomAnswer < ActiveRecord::Base
  belongs_to :room_question
  belongs_to :player
  belongs_to :answer

  validates :time, presence: true, numericality: { greter_than_or_equal_to: 0 }
  validates :answer, presence: true, uniqueness: { scope: :player }
  validate :answer_belongs_to_question

  def points
    return 0 unless answer.correct?

    20 - time
  end

  private

  def question
    room_question.question
  end

  def answer_belongs_to_question
    return unless room_question

    unless question.answers.include?(answer)
      errors.add(:answer, "doesn't belong to question")
    end
  end
end
