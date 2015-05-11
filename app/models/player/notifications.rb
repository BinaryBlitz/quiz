module Player::Notifications
  extend ActiveSupport::Concern

  def push_friend_request_from(player)
    message = "#{player.name} added you as a friend."
    options = {
      action: 'FRIEND_REQUEST', player: { id: player.id, name: player.name }
    }
    push_notification(message, options)
  end

  def push_achievement(badge)
    message = "You received an achievement: #{badge.name}"
    options = { action: 'ACHIEVEMENT', badge: { id: badge.id, name: badge.name } }
    push_notification(message, options)
  end

  def push_notification(message, options = {})
    push_tokens.each do |push_token|
      push_token.push(message, options)
    end
  end
end
