json.extract! game_session, :id, :offline
json.lobby_id game_session.player_lobby_id(current_player)
json.fact Fact.random

json.host do
  json.partial! 'players/player', player: game_session.host
  json.points current_player.score.topic_points(game_session.topic)
  json.extract! game_session.host, :multiplier
end

json.opponent do
  if game_session.opponent
    json.partial! 'players/player', player: game_session.opponent
    json.extract! game_session.opponent, :multiplier
    json.points game_session.opponent.score.topic_points(game_session.topic)
  else
    json.id nil
    json.username Player.random_username(current_player)
    json.email nil
    json.avatar_url nil
    json.points 0
    json.multiplier 1
  end
end

json.game_questions game_session.game_questions do |sq|
  json.partial! 'game_questions/game_question', game_session_question: sq
end

json.game_session_questions game_session.game_questions do |sq|
  json.partial! 'game_questions/game_question', game_session_question: sq
end
