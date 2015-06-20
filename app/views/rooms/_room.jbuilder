json.extract! room, :id, :player_id, :created_at

json.player do
  json.partial! 'players/player', player: room.player
end

json.participants room.players do |participant|
  json.partial! 'players/player', player: participant
end
