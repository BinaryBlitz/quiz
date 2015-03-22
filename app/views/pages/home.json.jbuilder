json.featured_topics { json.array! @featured_topics, :id, :name }
json.friends_favorite_topics { json.array! @friends_favorite_topics, :id, :name }
json.favorite_topics { json.array! @favorite_topics, :id, :name }
