json.partial! 'players/player', player: player
json.points topic ? player.topic_points(topic) : player.total_points
