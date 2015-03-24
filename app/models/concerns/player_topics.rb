module PlayerTopics
  extend ActiveSupport::Concerns

  def favorite_topic
    topic_result = topic_results.order(count: :desc).first
    topic_result.topic if topic_result
  end

  def favorite_topic_games
    favorite_topic ? topic_results.order(count: :desc).first.count : 0
  end

  def favorite_topics
    topic_results.order(count: :desc).limit(3).map(&:topic)
  end

  def friends_favorite_topics
    friends.sort_by(&:favorite_topic_games).map(&:favorite_topic).compact.first(3)
  end
end
