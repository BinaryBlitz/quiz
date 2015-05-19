json.extract! friend_request, :id, :friend_id, :created_at
json.player do
  json.partial! 'players/player', player: friend_request.player
end
