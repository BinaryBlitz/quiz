# == Schema Information
#
# Table name: rooms
#
#  id           :integer          not null, primary key
#  player_id    :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  friends_only :boolean          default(FALSE)
#  started      :boolean          default(FALSE)
#  size         :integer
#  topic_id     :integer
#

class Room < ApplicationRecord
  after_create :add_owner_to_participants

  belongs_to :player
  belongs_to :topic

  has_one :room_session, dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :players, through: :participations
  has_many :invites, dependent: :destroy

  validates :player, presence: true
  validates :topic, presence: true

  scope :visible, -> { where(started: false, friends_only: false) }
  scope :recent, -> { where('created_at > ?', 10.minutes.ago) }

  def self.visible_for(current_user)
    friends_ids = current_user.friends.ids
    where(friends_only: true).where(player_id: friends_ids)
  end

  def start
    return if started && room_session

    create_room_session
    notify_session_start
    update(started: true)
  end

  def visible_for?(current_player)
    return true unless friends_only

    player.friends.include?(current_player)
  end

  def player_finished?(current_player)
    participation = participations.find_by(player: current_player)
    participation && participation.finished?
  end

  def finish_as(current_player)
    participations.find_by(player: current_player).update(finished: true)
    add_points_for(current_player)

    options = { player_id: current_player.id, points: room_session.points_for(current_player) }
    Pusher.trigger("room-#{id}", 'player-finished', options)
    logger.debug "#{Time.zone.now} #{current_player} has finished the game in room \##{id}"
  end

  private

  def add_owner_to_participants
    participations.create(player: player, topic: topic)
  end

  # Notify about session start
  def notify_session_start
    session_data = JSON.parse(room_session.as_json)
    Pusher.trigger("room-#{id}", 'game-start', session_data)
    logger.debug "#{Time.zone.now}: Session sent to room \##{id}"
  end

  def add_points_for(current_player)
    topics = participations.includes(:topic).map(&:topic)
    topics.each do |topic|
      points = room_session.points_for(current_player, topic)
      topic_result = current_player.topic_results.find_or_create_by(topic: topic)
      topic_result.add_points(points)
    end
  end
end
