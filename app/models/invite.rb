# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Invite < ActiveRecord::Base
  after_create :notify_player

  belongs_to :room
  belongs_to :player

  validates :room, presence: true, uniqueness: { scope: :player }
  validates :player, presence: true

  private

  def notify_player
    player.push_notification('Вас пригласили в комнату', action: 'ROOM_INVITE' , room: as_json)
  end
end
