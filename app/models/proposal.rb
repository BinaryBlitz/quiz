# == Schema Information
#
# Table name: proposals
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  topic_id   :integer
#  content    :text
#  answers    :text             is an Array
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Proposal < ApplicationRecord
  belongs_to :player
  belongs_to :topic

  validates :player, presence: true
  validates :topic, presence: true
  validates :answers, presence: true

  def approve
    question = Question.new(content: content, topic: topic)

    answers.each_with_index do |answer, index|
      question.answers.build(content: answer, correct: index == 0)
    end

    question.save!
    destroy
    question
  end
end
