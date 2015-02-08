# == Schema Information
#
# Table name: lobbies
#
#  id          :integer          not null, primary key
#  query_count :integer
#  topic_id    :integer
#  player_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Lobby < ActiveRecord::Base
  belongs_to :topic
  belongs_to :player
  belongs_to :game_session

  validates :topic, presence: true
  validates :player, presence: true

  MAX_QUERY_COUNT = 6

  def find_opponent_lobby
    Lobby.where(created_at: (Time.zone.now - 15.seconds)..(Time.zone.now))
      .where(game_session: nil)
      .where(topic: topic)
      .where(closed: false)
      .where.not(player: player).first
  end

  def close
    update(closed: true)
  end

  def increment_count
    update(query_count: query_count + 1)
  end
end
