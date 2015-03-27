json.partial! 'player', player: @player
json.is_friend @is_friend
json.wins @score[0]
json.losses @score[1]

json.achievements do
  json.array! @player.badges, :id, :name, :description
end
