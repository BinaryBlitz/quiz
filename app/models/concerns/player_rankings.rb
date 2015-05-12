module PlayerRankings
  extend ActiveSupport::Concern

  included do
    # scope :order_by_points, -> { order(points: :desc) }
    # scope :order_by_weekly_points, -> { order(weekly_points: :desc) }
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
    topic_result = topic_results.find_by(topic: topic)
    return 0 unless topic_result
    topic_result.older_than_week? ? 0 : topic_result.weekly_points
  end

  def category_points(category)
    topic_results.where(category: category).sum(:points)
  end

  def weekly_category_points(category)
    topic_results.where(category: category)
      .where('updated_at > ?', Time.zone.now.beginning_of_week)
      .sum(:weekly_points)
  end

  module ClassMethods
    def order_by_points
      joins(:topic_results)
        .select('players.*, sum(topic_results.points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end

    def order_by_weekly_points
      joins(:topic_results)
        .where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
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
        .where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
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
        .where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
        .select('players.*, sum(topic_results.weekly_points) as total_points')
        .group('players.id')
        .order('total_points desc')
    end
  end
end
