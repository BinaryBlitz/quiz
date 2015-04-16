json.extract! topic, :id, :name
json.background_url topic.category.background_url
json.points current_player.topic_points(topic)
json.visible topic.purchase_type ? current_player.purchase_types.include?(topic.purchase_type) : true
