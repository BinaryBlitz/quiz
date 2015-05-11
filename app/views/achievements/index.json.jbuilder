json.array! @achievements do |achievement|
  json.partial! 'achievements/achievement', achievement: achievement
  json.achieved current_player.badges.include?(achievement)
end
