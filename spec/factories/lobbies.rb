# == Schema Information
#
# Table name: lobbies
#
#  id          :integer          not null, primary key
#  query_count :integer
#  topic_id    :integer
#  player_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryGirl.define do
  factory :lobby do
    query_count 1
    topic
    player
    closed false
  end
end
