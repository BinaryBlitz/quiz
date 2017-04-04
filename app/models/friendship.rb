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

class Friendship < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :player
  belongs_to :friend, class_name: 'Player'

  validates :player, presence: true
  validates :friend, presence: true, uniqueness: { scope: :player }
  validate :not_self

  private

  def not_self
    errors.add(:friend, "can't be equal to player") if player == friend
  end

  def create_inverse_relationship
    friend.friends << player
  end

  def destroy_inverse_relationship
    friend.friends.destroy(player)
  end
end
