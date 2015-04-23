json.extract! game_session, :id, :offline
json.lobby_id game_session.player_lobby_id(current_player)

json.host do
  json.partial! 'players/player', player: game_session.host
  json.points current_player.topic_points(game_session.topic)
  json.extract! game_session.host, :multiplier
end

json.opponent do
  if game_session.offline?
    json.id nil
    json.name Player.random_name
    json.username Player.random_username
    json.email nil
    json.avatar_url nil
    json.points 0
    json.multiplier 1
  else
    json.partial! 'players/player', player: game_session.opponent
    json.extract! game_session.opponent, :multiplier
    json.points game_session.opponent.topic_points(game_session.topic)
  end
end

json.game_session_questions game_session.game_session_questions do |sq|
  json.partial! 'game_session_questions/game_session_question', game_session_question: sq
end
