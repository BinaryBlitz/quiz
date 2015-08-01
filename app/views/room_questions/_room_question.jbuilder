json.extract! room_question, :id

json.question do
  json.partial! 'questions/question', question: room_question.question
end

json.room_answers room_question.room_answers, partial: 'room_answers/room_answer', as: :room_answer
