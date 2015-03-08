class Friendship < ActiveRecord::Base
  validate :not_self

  belongs_to :player
  belongs_to :friend, class_name: 'Player'

  validates :friend, uniqueness: { scope: :player }

  def not_self
    errors.add(:friend, "can't be equal to player") if player == friend
  end
end
