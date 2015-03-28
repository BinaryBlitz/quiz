json.partial! 'player', player: @player
json.is_friend @is_friend

json.total_score do
  json.wins @total_score[0]
  json.draws @total_score[1]
  json.losses @total_score[2]
end

json.score do
  json.wins @score[0]
  json.losses @score[1]
end

json.favorite_topics @player.favorite_topics do |topic|
  json.extract! topic, :id, :name
  json.points @player.topic_points(topic)
end

json.achievements do
  json.array! @player.badges, :id, :name, :description
end
