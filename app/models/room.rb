# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  player_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  friends_only :boolean          default(FALSE)
#

class Room < ActiveRecord::Base
  after_create :add_owner_to_participants

  belongs_to :player

  has_one :room_session, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :players, through: :participations

  validates :player, presence: true

  attr_accessor :topic, :topic_id

  def start
    create_room_session
    notify_session_start
  end

  def visible_for?(current_player)
    return true unless friends_only

    player.friends.include?(current_player)
  end

  def invite(new_player)
    new_player.push_notification("Вас пригласили в комнату", action: 'ROOM_INVITE' , room: as_json)
  end

  private

  def add_owner_to_participants
    self.topic ||= Topic.find(topic_id)
    participations.create(player: player, topic: topic)
  end

  # Notify about session start
  def notify_session_start
    session_data = JSON.parse(room_session.as_json)
    Pusher.trigger("room-#{id}", 'game-start', session_data)
    logger.debug "#{Time.zone.now}: Session sent to room \##{id}"
  end
end
