json.array! @purchases do |purchase_type|
  json.extract! purchase_type, :identifier, :topic_id
end
