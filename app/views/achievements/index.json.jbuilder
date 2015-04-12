json.array! @achievements do |achievement|
  json.extract! achievement, :id, :name, :description
  json.icon_url achievement.icon_url
  json.achieved current_player.badges.include?(achievement)
end
