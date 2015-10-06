json.extract! invite, :id, :room_id, :player_id, :created_at

json.creator do
  json.partial! 'players/player', player: invite.creator
end
