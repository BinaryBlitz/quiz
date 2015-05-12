module PlayerRankings
  extend ActiveSupport::Concern

  included do
  end

  def wins
    topic_results.sum(:wins)
  end

  def draws
    topic_results.sum(:draws)
  end

  def losses
    topic_results.sum(:losses)
  end

  def weekly_points
    topic_results.recent.sum(:weekly_points)
  end

  def topic_points(topic)
    topic_results.find_by(topic: topic).points rescue 0
  end

  def weekly_topic_points(topic)
    topic_results.recent.find_by(topic: topic).weekly_points rescue 0
  end

  def category_points(category)
    topic_results.where(category: category).sum(:points)
  end

  def weekly_category_points(category)
    topic_results.where(category: category).recent.sum(:weekly_points)
  end

  module ClassMethods
    def recent_results
      where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
    end

    def order_by_points
      joins(:topic_results)
        .select('players.*, sum(topic_results.points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end

    def order_by_weekly_points
      joins(:topic_results)
        .recent_results
        .select('players.*, sum(topic_results.weekly_points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end

    def order_by_topic(topic)
      joins(:topic_results).where('topic_id = ?', topic.id).order('topic_results.points DESC')
    end

    def order_by_weekly_topic(topic)
      joins(:topic_results)
        .where('topic_id = ?', topic.id)
        .recent_results
        .order('topic_results.weekly_points DESC')
    end

    def order_by_category(category)
      joins(:topic_results)
        .where('category_id = ?', category.id)
        .select('players.*, sum(topic_results.points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end

    def order_by_weekly_category(category)
      joins(:topic_results)
        .where('category_id = ?', category.id)
        .recent_results
        .select('players.*, sum(topic_results.weekly_points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end
  end
end
