json.array! @friendships do |friendship|
  json.partial! 'players/player', player: friendship.player
  json.extract! friendship, :viewed
end
