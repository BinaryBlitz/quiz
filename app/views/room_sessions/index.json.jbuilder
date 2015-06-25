json.array!(@room_sessions) do |room_session|
  json.extract! room_session, :id
  json.url room_session_url(room_session, format: :json)
end
