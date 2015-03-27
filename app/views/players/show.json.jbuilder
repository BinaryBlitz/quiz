json.partial! 'player', player: @player
json.is_friend @is_friend

json.stats do
  json.wins @stats[0]
  json.draws @stats[1]
  json.losses @stats[2]
end

json.score do
  json.wins @score[0]
  json.losses @score[1]
end

json.achievements do
  json.array! @player.badges, :id, :name, :description
end
