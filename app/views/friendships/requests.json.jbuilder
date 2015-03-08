json.array! @friendships do |friendship|
  json.id friendship.player_id
  json.name friendship.player.name
  json.extract! friendship, :viewed
end
