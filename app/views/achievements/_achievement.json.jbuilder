json.cache! achievement do
  json.extract! achievement, :id, :name, :description
  json.icon_url Achievement.icon_url_for(achievement)
end
