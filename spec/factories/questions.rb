FactoryGirl.define do
  factory :question do
    content "What is the capital of the UK?"
    image_url "http://rubyonrails.org/images/rails.png"
    bounty 1
    topic
  end
end
