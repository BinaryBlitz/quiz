json.layer_needs_authentication false

json.featured_topics do
  json.partial! 'home_topics', topics: @featured_topics
end

json.friends_favorite_topics do
  json.partial! 'home_topics', topics: @friends_favorite_topics
end

json.favorite_topics do
  json.partial! 'home_topics', topics: @favorite_topics
end

json.random_topics do
  json.partial! 'home_topics', topics: Topic.visible.random(3)
end

json.recent_topics do
  json.partial! 'home_topics', topics: Topic.recent(3)
end

json.challenges do
  json.partial! 'challenges', lobbies: @challenges
end
json.challenged do
  json.partial! 'challenged', lobbies: @challenged
end

json.invites @invites do |invite|
  json.partial! 'invites/invite', invite: invite
end

json.random_rooms Room.recent.visible.limit(2).order('RANDOM()') do |room|
  json.partial! 'rooms/room', room: room
end
