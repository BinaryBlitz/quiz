task clean_up: :environment do
  GameSession.where(offline: true).order('RANDOM()').limit(1000).destroy_all
  Lobby.order('RANDOM()').limit(1000).destroy_all
  Player.where(username: nil).destroy_all
end
