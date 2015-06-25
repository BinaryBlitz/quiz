json.extract! room_session, :id, :created_at

json.room_questions room_session.room_questions do |question|
  json.question do
    json.partial! 'questions/question', question: question
  end

  json.room_answers question.room_answers do |room_answer|
    json.partial! 'room_answers/room_answer', room_answer: room_answer
  end
end
