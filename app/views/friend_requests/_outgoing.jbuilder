json.extract! friend_request, :id, :player_id, :created_at
json.friend do
  json.partial! 'players/player', player: friend_request.friend
end
