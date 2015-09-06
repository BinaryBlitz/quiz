json.extract! @purchase, :id, :player_id, :created_at, :updated_at

json.purchase_type do
  json.extract! @purchase.purchase_type, :id, :identifier, :multiplier, :topic
end
