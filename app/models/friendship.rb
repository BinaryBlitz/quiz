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

class Friendship < ActiveRecord::Base
  validate :not_self

  belongs_to :player
  belongs_to :friend, class_name: 'Player'

  validates :friend, uniqueness: { scope: :player }

  def not_self
    errors.add(:friend, "can't be equal to player") if player == friend
  end
end
