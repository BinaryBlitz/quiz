json.array!(@room_answers) do |room_answer|
  json.extract! room_answer, :id
  json.url room_answer_url(room_answer, format: :json)
end
