json.extract! topic, :id, :name, :price
json.background_url topic.category.background_url
json.points current_player.topic_points(topic)
json.purchased current_player.purchase_types.include?(topic.purchase_type)
