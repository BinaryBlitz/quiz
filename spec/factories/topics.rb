# == Schema Information
#
# Table name: topics
#
#  id           :integer          not null, primary key
#  name         :string
#  visible      :boolean          default("false")
#  expires_at   :date
#  price        :integer          default("0")
#  played_count :integer          default("0")
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :topic do
    name "My Topic"
    visible true
    expires_at "2014-12-21"
    price 1
    played_count 1
    category

    transient do
      question_count 6
    end

    after(:create) do |topic, evaluator|
      create_list(:question, evaluator.question_count, topic: topic)
    end
  end
end
