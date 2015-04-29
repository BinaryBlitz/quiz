module Notifiable
  extend ActiveSupport::Concern

  def push_friend_request_from(player)
    message = "#{player.name} added you as a friend."
    options = { action: 'FRIEND_REQUEST', player: { id: player.id, name: player.name } }
    push_notification(message, options)
  end

  def push_achievement(badge)
    message = "You received an achievement: #{badge.name}"
    options = {
      action: 'ACHIEVEMENT',
      badge: { id: badge.id, name: badge.name, icon_url: Achievement.icon_url_for(badge) }
    }
    push_notification(message, options)
  end

  def push_challenge(lobby)
    message = "#{lobby.player.name} has challenged you."
    options = { action: 'CHALLENGE', lobby: { id: lobby.id } }
    push_notification(message, options)
  end

  def push_decline(lobby)
    message = "#{lobby.game_session.opponent} has declined your challenge."
    options = { action: 'CHALLENGE_DECLINED', lobby: { id: lobby.id } }
    push_notification(message, options)
  end

  def push_challenge_results(game_session)
    message = "#{game_session.opponent} has played your challenge."
    options = { action: 'CHALLENGE_FINISHED', game_session: { id: game_session.id } }
    push_notification(message, options)
  end

  def push_notification(message, options = {})
    push_tokens.each do |push_token|
      push_token.push(message, options)
    end
  end
end
