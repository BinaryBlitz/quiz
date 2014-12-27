json.extract! session_question, :id, :session_id, :host_answer_id, :opponent_answer_id, :host_time, :opponent_time
# Use question partial
json.question do
  json.partial! 'questions/question', question: session_question.question
end