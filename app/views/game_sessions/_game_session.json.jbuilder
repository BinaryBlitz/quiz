json.extract! game_session, :id, :host_id, :opponent_id, :offline
json.lobby_id game_session.player_lobby_id(current_player)

json.host_name game_session.host.name
json.opponent_name game_session.offline ? Player.random_name : game_session.opponent.name

json.host_avatar_url game_session.host.avatar_url
json.opponent_avatar_url game_session.offline ? nil : game_session.opponent.avatar_url

json.game_session_questions game_session.game_session_questions do |sq|
  json.partial! 'game_session_questions/game_session_question', game_session_question: sq
end
