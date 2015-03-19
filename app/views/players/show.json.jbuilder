json.extract! @player, :id, :email, :name
json.is_friend @is_friend

json.achievements do
  json.array! @player.badges, :id, :name, :description
end
