json.extract! room, :id, :player_id, :created_at

json.owner do
  json.player { json.partial! 'players/player', player: room.player }
  json.topic { json.partial! 'topics/topic', topic: room.topic }
end

json.participations room.participations do |participation|
  json.topic do
    json.partial! 'topics/topic', topic: participation.topic
  end

  json.player do
    json.partial! 'players/player', player: participation.player
  end
end
