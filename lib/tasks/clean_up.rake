task clean_up: :environment do
  GameSession.where(offline: true).order('RANDOM()').limit(10000).destroy_all
  Lobby.order('RANDOM()').limit(5000).destroy_all
  Player.where(username: nil).destroy_all

  # Destroy invalid device tokens
  Rpush::Apns::Feedback.find_each do |feedback|
    player = Player.find_by(device_token: feedback.device_token)
    # Skip if player is not found
    next unless player.present?
    # Skip if there is another token
    next if player.device_token != feedback.device_token
    # Delete token otherwise
    player.update_attribute(:device_token, feedback.device_token)
  end
end
