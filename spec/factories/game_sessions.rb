# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#

FactoryGirl.define do
  factory :game_session do
    host
    opponent
    topic
    offline true
  end

  factory :online_session do
    host
    opponent
    topic
    offline false
  end
end
