# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default(FALSE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :answer, aliases: [:host_answer] do
    content 'London'
    question
    correct true
  end

  factory :opponent_answer, class: Answer do
    content 'New York'
    question
    correct false
  end

  factory :second_question_correct_answer, class: Answer do
    content 'Russia'
    question :second_question
    correct true
  end

  factory :second_question_wrong_answer, class: Answer do
    content 'Canada'
    question :second_question
    correct false
  end
end
