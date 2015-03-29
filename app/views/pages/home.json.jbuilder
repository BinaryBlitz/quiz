json.featured_topics do
  json.partial! 'home_topics', topics: @featured_topics
end
json.friends_favorite_topics do
  json.partial! 'home_topics', topics: @friends_favorite_topics
end
json.favorite_topics do
  json.partial! 'home_topics', topics: @favorite_topics
end

json.challenges do
  json.partial! 'home_challenges', lobbies: @challenges
end
json.challenged do
  json.partial! 'home_challenges', lobbies: @challenged
end
