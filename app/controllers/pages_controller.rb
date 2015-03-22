class PagesController < ApplicationController
  def home
    @featured_topics = Topic.where(featured: true).limit(3)
    @friends_favorite_topics = current_player.friends_favorite_topics
    @favorite_topics = current_player.favorite_topics
    render formats: :json
  end
end
