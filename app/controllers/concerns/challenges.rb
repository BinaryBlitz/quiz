module Challenges
  extend ActiveSupport::Concern

  private

  def push_challenge(opponent)
    message = "#{current_player} challenged you."
    options = { action: 'CHALLENGE', lobby: { id: @lobby.id } }
    opponent.push_notification(message, options)
  end

  def push_decline
    message = "#{current_player} has declined the challenge."
    options = { action: 'CHALLENGE_DECLINED', lobby: { id: @lobby.id } }
    @lobby.player.push_notification(message, options)
  end
end
