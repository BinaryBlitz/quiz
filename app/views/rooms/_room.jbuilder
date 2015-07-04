json.extract! room, :id, :player_id, :created_at, :friends_only

json.participations room.participations do |participation|
  json.extract! participation, :id, :ready, :finished

  json.topic do
    json.partial! 'topics/topic', topic: participation.topic
  end

  json.player do
    json.partial! 'players/player', player: participation.player
    json.is_admin room.player_id == participation.player_id
  end
end
