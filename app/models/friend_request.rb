# == Schema Information
#
# Table name: friend_requests
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  friend_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FriendRequest < ActiveRecord::Base
  after_create :notify

  belongs_to :player
  belongs_to :friend, class_name: 'Player'

  validates :player, presence: true
  validates :friend, presence: true, uniqueness: { scope: :player }
  validate :not_self
  validate :not_friends
  validate :not_pending

  def accept
    player.friends << friend
    destroy
  end

  private

  def not_self
    errors.add(:friend, "can't be equal to player") if player == friend
  end

  def not_friends
    return unless player
    errors.add(:friend, 'is already added') if player.friends.include?(friend)
  end

  def not_pending
    return unless friend
    errors.add(:friend, 'already requested friendship') if friend.pending_friends.include?(player)
  end

  def notify
    message = "#{player} добавил вас в друзья"
    options = { action: 'FRIEND_REQUEST', player: { id: player.id, username: player.username } }
    Notifier.new(friend, message, options)
  end
end
