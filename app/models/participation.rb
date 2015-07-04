# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  player_id  :integer
#  room_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer
#

class Participation < ActiveRecord::Base
  after_create :notify_new_participant
  after_destroy :notify_participant_left

  belongs_to :player
  belongs_to :room
  belongs_to :topic

  validates :player, presence: true
  validates :room, presence: true, uniqueness: { scope: :player, message: 'already joined' }
  validates :topic, presence: true

  private

  def notify_new_participant
    Pusher.trigger("room-#{room_id}", 'new-participant', {})
    logger.debug "#{Time.zone.now}: #{player} has joined room \##{room.id}"
  end

  def notify_participant_left
    Pusher.trigger("room-#{room_id}", 'participant-left', {})
    logger.debug "#{Time.zone.now}: #{player} has left room \##{room.id}"
  end
end
