json.extract! room_answer, :id, :time, :player_id
json.is_correct room_answer.answer.correct?
