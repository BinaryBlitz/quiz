json.extract! game_session, :id, :offline
json.lobby_id game_session.player_lobby_id(current_player)

json.host do
  json.extract! game_session.host, :id, :name, :avatar_url, :multiplier
  json.points current_player.topic_points(game_session.topic)
end

json.opponent do
  if game_session.offline?
    json.id nil
    json.name Player.random_name
    json.avatar_url nil
    json.points 0
    json.multiplier 1
  else
    json.extract! game_session.opponent, :id, :name, :avatar_url, :multiplier
    json.points game_session.opponent.topic_points(game_session.topic)
  end
end

json.game_session_questions game_session.game_session_questions do |sq|
  json.partial! 'game_session_questions/game_session_question', game_session_question: sq
end
