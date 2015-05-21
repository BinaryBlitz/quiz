json.incoming do
  json.array! @incoming do |incoming_request|
    json.partial! 'incoming', friend_request: incoming_request
  end
end

json.outgoing do
  json.array! @outgoing do |outgoing_request|
    json.partial! 'outgoing', friend_request: outgoing_request
  end
end
