# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  friend_id  :integer
#  viewed     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :friendship do
    player nil
    friend_id 1
  end
end
