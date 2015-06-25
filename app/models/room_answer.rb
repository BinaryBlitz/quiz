# == Schema Information
#
# Table name: room_answers
#
#  id               :integer          not null, primary key
#  room_question_id :integer
#  participation_id :integer
#  time             :integer          default(0)
#  answer_id        :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class RoomAnswer < ActiveRecord::Base
  belongs_to :room_question
  belongs_to :participation
  belongs_to :answer

  def points
    return 0 unless answer.correct?

    20 - time
  end

  private

  def question
    room_question.question
  end
end
