# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class FriendshipTest < ActiveSupport::TestCase
  def setup
    @friendship = Friendship.new(player: players(:foo), friend: players(:bar))
  end

  test 'self friendships are restricted' do
    @friendship.update(friend: @friendship.player)
    assert @friendship.invalid?
  end
end
