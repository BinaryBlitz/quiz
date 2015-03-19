json.array! @achievements do |achievement|
  json.extract! achievement, :id, :name, :description
  json.achieved @player_achievements.include?(achievement)
end
