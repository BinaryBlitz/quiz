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
