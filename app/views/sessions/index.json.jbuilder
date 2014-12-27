json.array! @sessions do |session|
  json.partial! 'session', session: session
end