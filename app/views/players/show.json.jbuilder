json.partial! 'player', player: @player
json.is_friend @is_friend

json.total_score do
  json.wins @player.score.wins
  json.draws @player.score.draws
  json.losses @player.score.losses
end

json.score do
  json.wins @score.wins
  json.losses @score.losses
end

json.favorite_topics @player.favorite_topics do |topic|
  json.partial! 'topics/topic', topic: topic
  json.points @player.topic_points(topic)
end

json.achievements do
  json.array! @player.badges do |achievement|
    json.partial! 'achievements/achievement', achievement: achievement
  end
end
