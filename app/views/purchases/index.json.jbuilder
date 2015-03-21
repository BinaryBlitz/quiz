json.array! @purchase_types do |purchase_type|
  json.extract! purchase_type, :identifier, :topic_id
  json.purchased !purchase_type.purchases.find_by(player: current_player).nil?
end
