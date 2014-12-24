# == Schema Information
#
# Table name: sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  online      :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :session do
    host
    opponent
    topic
    online false
  end
end
