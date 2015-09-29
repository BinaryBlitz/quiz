json.cache! topic do
  json.extract! topic, :id, :name, :paid
  json.background_url topic.category.background_url
  # TODO: Render visibility
  json.visible true
end

json.points current_player.score.topic_points(topic)
json.available !topic.paid || current_player.topics_unlocked?
