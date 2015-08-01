json.array!(@messages) do |message|
  json.extract! message, :id, :content, :creator_id, :created_at
end
