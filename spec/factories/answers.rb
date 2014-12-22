# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  content     :text
#  question_id :integer
#  correct     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :answer, aliases: [:host_answer] do
    content "London"
    question
    correct true
  end

  factory :opponent_answer, class: Answer do
    content "New York"
    question
    correct false
  end
end
