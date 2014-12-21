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
