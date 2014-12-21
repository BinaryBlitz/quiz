FactoryGirl.define do
  factory :topic do
    name "My Topic"
    visible true
    expires_at "2014-12-21"
    price 1
    played_count 1
    category
  end
end
