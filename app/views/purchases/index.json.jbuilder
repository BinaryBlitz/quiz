json.array! @purchase_types do |purchase_type|
  json.extract! purchase_type, :identifier, :topic
  json.purchased current_player.purchased?(purchase_type)
  json.expires_at current_player.purchases.find_by(purchase_type: purchase_type).try(:expires_at)
end
