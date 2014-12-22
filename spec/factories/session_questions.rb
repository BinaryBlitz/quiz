# == Schema Information
#
# Table name: session_questions
#
#  id                 :integer          not null, primary key
#  session_id         :integer
#  question_id        :integer
#  host_answer_id     :integer
#  opponent_answer_id :integer
#  host_time          :integer          default("0")
#  opponent_time      :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

FactoryGirl.define do
  factory :session_question do
    session
    question
    association :host_answer, factory: :host_answer
    association :opponent_answer, factory: :opponent_answer
    host_time 2
    opponent_time 4
  end
end
