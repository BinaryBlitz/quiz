json.extract! invite, :id, :room_id, :player_id

json.creator do
  json.partial! 'players/player', player: invite.creator
end
