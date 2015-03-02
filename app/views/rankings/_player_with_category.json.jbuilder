json.extract! player, :id, :name
if @weekly
  json.points player.weekly_category_points(category)
else
  json.points player.category_points(category)
end
