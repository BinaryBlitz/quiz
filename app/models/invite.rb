# == Schema Information
#
# Table name: invites
#
#  id         :integer          not null, primary key
#  room_id    :integer
#  player_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  creator_id :integer
#

class Invite < ActiveRecord::Base
  after_create :notify_player

  belongs_to :room
  belongs_to :player
  belongs_to :creator, class_name: 'Player'

  validates :room, presence: true, uniqueness: { scope: :player }
  validates :player, presence: true

  private

  def notify_player
    options = { action: 'ROOM_INVITE' , invite: as_json, creator: creator.as_json }
    player.push_notification('Вас пригласили в комнату', options)
  end
end
