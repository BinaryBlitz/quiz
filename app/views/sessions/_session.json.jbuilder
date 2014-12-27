json.extract! session, :id, :host_id, :opponent_id, :online
json.session_questions session.session_questions do |sq|
  json.partial! 'session_questions/session_question', session_question: sq
end