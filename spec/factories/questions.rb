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

FactoryGirl.define do
  factory :question do
    content "What is the capital of the UK?"
    image_url "http://rubyonrails.org/images/rails.png"
    bounty 1
    topic

    transient do
      answer_count 4
    end

    after(:create) do |question, evaluator|
      create_list(:answer, 1, question: question)
      create_list(:answer, 3, question: question, correct: false)
    end
  end

  factory :second_question do
    content "What is the largest country in the world?"
    bounty 1
    topic

    after(:create) do |question|
      create_list(:second_question_correct_answer, 1, question: question)
      create_list(:second_question_wrong_answer, 3, question: question)
    end
  end
end
