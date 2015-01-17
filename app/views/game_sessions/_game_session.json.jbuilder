json.extract! game_session, :id, :host_id, :opponent_id, :offline
json.game_session_questions game_session.game_session_questions do |sq|
  json.partial! 'game_session_questions/game_session_question', game_session_question: sq
end
