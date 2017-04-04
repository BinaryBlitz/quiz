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

class RoomAnswer < ApplicationRecord
  belongs_to :room_question
  belongs_to :player
  belongs_to :answer

  validates :time, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :answer, presence: true
  validates :player, presence: true
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

    errors.add(:answer, "doesn't belong to question") unless question.answers.include?(answer)
  end
end
