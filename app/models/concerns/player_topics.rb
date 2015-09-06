module PlayerTopics
  extend ActiveSupport::Concerns

  def favorite_topic
    Rails.cache.fetch("#{id}/favorite_topic", expires_in: 24.hours) do
      topic_result = topic_results.order(count: :desc).first
      topic_result.topic if topic_result
    end
  end

  def favorite_topic_games
    favorite_topic ? topic_results.order(count: :desc).first.count : 0
  end

  def favorite_topics
    Rails.cache.fetch("#{id}/favorite_topics", expires_in: 24.hours) do
      topic_results.order(count: :desc).limit(3).map(&:topic)
    end
  end

  def friends_favorite_topics
    Rails.cache.fetch("#{id}/friends_favorite_topics", expires_in: 24.hours) do
      topics = []
      friends.sort_by(&:favorite_topic_games).each do |player|
        topic = player.favorite_topic
        topics << topic if !topics.include?(topic) && topic
      end
      topics.first(3)
    end
  end
end
