json.extract! room_session, :id, :created_at

json.room_questions room_session.room_questions do |room_question|
  json.room_question do
    json.partial! 'room_questions/room_question', room_question: room_question
  end
end
