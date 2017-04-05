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
#  ready      :boolean          default(FALSE)
#  finished   :boolean          default(FALSE)
#

class Participation < ApplicationRecord
  after_create :notify_new_participant
  after_update :notify_status_changed
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

  def notify_status_changed
    if ready_changed?
      Pusher.trigger("room-#{room.id}", 'status-changed', participation: as_json)
      logger.debug "#{Time.zone.now} Readiness status in room \##{room.id} has changed"
    end

    if topic_id_changed?
      Pusher.trigger("room-#{room.id}", 'topic-changed', participation: as_json)
      logger.debug "#{Time.zone.now} Player topic in room \##{room.id} has changed"
    end
  end
end
