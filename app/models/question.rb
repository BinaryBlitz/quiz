# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  content    :text
#  image_url  :string
#  bounty     :integer          default("1")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

class Question < ActiveRecord::Base
  has_many :answers, -> { order(id: :asc) }, dependent: :destroy
  belongs_to :topic

  validates :content, presence: true
  validates :topic, presence: true
  validates :bounty, numericality: { greater_than_or_equal_to: 0 }

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: lambda { |a| a[:content].blank? }

  # Finds the first answer and updates it to be the correct one
  def set_correct_answer
    # Skip if there're no answers
    if answers.any?
      answers.first.update(correct: true)
      # Set other answers to incorrect, skip if new record
      set_incorrect_answers unless new_record?
    end
  end

  private

  # Finds and updates correct answers to incorrect
  def set_incorrect_answers
    # Get all answers (except the first one)
    if other_answers = answers[1..-1]
      # debugger
      other_answers.each do |answer|
        # Set to incorrect if it was correct
        answer.update(correct: true) if answer.correct?
      end
    end
  end

end
