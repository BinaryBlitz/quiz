# == Schema Information
#
# Table name: questions
#
#  id            :integer          not null, primary key
#  content       :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  topic_id      :integer
#  image         :string
#  reports_count :integer          default(0)
#

class Question < ApplicationRecord
  belongs_to :topic
  has_many :answers, -> { order(id: :asc) }, dependent: :destroy
  has_many :room_questions, dependent: :destroy
  has_many :game_questions, dependent: :destroy
  has_many :reports, dependent: :destroy

  mount_uploader :image, QuestionImageUploader

  validates :content, presence: true
  validates :topic, presence: true

  accepts_nested_attributes_for :answers,
                                reject_if: -> (answer) { answer[:content].blank? },
                                allow_destroy: true
  validates :answers, length: { is: 4, wrong_length: 'count must be equal to 4' }

  # Finds the first answer and updates it to be the correct one
  def set_correct_answer
    # Skip if there're no answers
    return unless answers.any?
    answers.first.update(correct: true)
    # Set other answers to incorrect, skip if new record
    set_incorrect_answers unless new_record?
  end

  # Get correct answer
  def correct_answer
    answers.find_by(correct: true)
  end

  # Get random incorrect answer
  def random_incorrect_answer
    answers.where(correct: false).sample if answers.any?
  end

  def valid_answer?(answer)
    answers.include?(answer)
  end

  private

  # Finds and updates correct answers to incorrect
  # TODO: Refactor this method, set default value to false
  def set_incorrect_answers
    # Get all answers (except the first one)
    other_answers = answers.drop(1)
    return unless other_answers
    other_answers.each do |answer|
      # Set to incorrect if it was correct
      answer.update(correct: true) if answer.correct?
    end
  end
end
