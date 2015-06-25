json.array!(@room_questions) do |room_question|
  json.extract! room_question, :id
  json.url room_question_url(room_question, format: :json)
end
