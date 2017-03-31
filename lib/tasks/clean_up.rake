task clean_up: :environment do
  GameSession.where(offline: true).order('RANDOM()').limit(10000).destroy_all
  Lobby.order('RANDOM()').limit(5000).destroy_all
  Player.where(username: nil).destroy_all

  # Destroy invalid device tokens
  Rpush::Apns::Feedback.find_each do |feedback|
    DeviceToken.find_by(token: feedback.device_token)&.destroy
  end
end
