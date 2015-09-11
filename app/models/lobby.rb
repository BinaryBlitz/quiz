# == Schema Information
#
# Table name: lobbies
#
#  id              :integer          not null, primary key
#  query_count     :integer          default(0)
#  closed          :boolean          default(FALSE)
#  topic_id        :integer
#  player_id       :integer
#  game_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenge       :boolean          default(FALSE)
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

  def challenge_player(opponent)
    self.challenge = true
    generate_challenge(opponent)
    notify_opponent(opponent)
    save && self
  end

  def decline_challenge(current_player)
    close
    logger.debug "#{current_player} declined the challenge of #{game_session.host}."
    notify_declined
  end

  def increment_count
    update(query_count: query_count + 1)
  end

  def generate_challenge(opponent)
    build_game_session(host: player, opponent: opponent, topic: topic, offline: false)
  end

  private

  def notify_opponent(opponent)
    message = "#{player} бросил вам вызов"
    options = { action: 'CHALLENGE', lobby: as_json }
    Notifier.new(opponent, message, options).push
  end

  def notify_declined
    Pusher.trigger("player-session-#{game_session.host.id}", 'challenge-declined', {})

    message = "#{lobby.game_session.opponent} отклонил ваш вызов"
    options = { action: 'CHALLENGE_DECLINED', lobby: { id: lobby.id } }
    Notifier.new(game_session.host, message, options).push
  end
end
