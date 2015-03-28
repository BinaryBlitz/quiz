json.array! @achievements do |achievement|
  json.extract! achievement, :id, :name, :description
  json.achieved current_player.badges.include?(achievement)
end
