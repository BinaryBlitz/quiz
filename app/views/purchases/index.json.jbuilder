json.array! @purchase_types do |purchase_type|
  json.extract! purchase_type, :identifier, :topic_id
  json.purchased !purchase_type.purchases.find_by(player: current_player).nil?
  purchase = current_player.purchases.where(purchase_type: purchase_type).order(expires_at: :asc).last
  json.expires_at purchase.expires_at if purchase
end
