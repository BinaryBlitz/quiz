json.array! @game_sessions do |session|
  json.partial! 'game_session', game_session: session
end