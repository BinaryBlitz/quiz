json.array! @incoming do |incoming_request|
  json.partial! 'friend_request', friend_request: incoming_request
end

json.array! @outgoing do |outgoing_request|
  json.partial! 'friend_request', friend_request: outgoing_request
end
