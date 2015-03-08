json.array! @friendships do |friendship|
  json.id friendship.friend_id
  json.name friendship.friend.name
  json.extract! friendship, :viewed
end
