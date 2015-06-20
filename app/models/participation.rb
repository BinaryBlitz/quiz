# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participation < ActiveRecord::Base
  belongs_to :player
  belongs_to :room

  validates :player, presence: true
  validates :room, presence: true, uniqueness: { scope: :player, message: 'already joined' }
  validate :not_owner

  private

  def not_owner
    errors.add(:player, 'owns this room') if room && player == room.player
  end
end
