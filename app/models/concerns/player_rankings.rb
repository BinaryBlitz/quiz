module PlayerRankings
  extend ActiveSupport::Concern

  def score
    Score.new(wins, draws, losses)
  end

  def total_points
    topic_results.sum(:points)
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

  private

  def wins
    topic_results.sum(:wins)
  end

  def draws
    topic_results.sum(:draws)
  end

  def losses
    topic_results.sum(:losses)
  end

  module ClassMethods
    def recent_results
      where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
    end

    def order_by_points(limit = 20)
      Rails.cache.fetch("rankings_general", expires_in: 1.hour) do
        joins(:topic_results)
          .select('players.*, sum(topic_results.points) as total_points')
          .group('players.id')
          .order('total_points desc')
          .limit(limit)
      end
    end

    def position_general(current_player)
      Player.joins(:topic_results)
        .group('players.id')
        .having('sum(topic_results.points) > ?', current_player.total_points)
        .count.size
    end

    def order_by_weekly_points(limit = 20)
      Rails.cache.fetch("rankings_weekly", expires_in: 1.hour) do
        joins(:topic_results)
          .recent_results
          .select('players.*, sum(topic_results.weekly_points) as total_points')
          .group('players.id')
          .order('total_points desc')
          .limit(limit)
      end
    end

    def position_weekly(current_player)
      Player.joins(:topic_results)
        .group('players.id')
        .having('sum(topic_results.weekly_points) > ?', current_player.weekly_points)
        .count.size
    end

    def order_by_topic(topic)
      joins(:topic_results)
        .where('topic_id = ?', topic.id)
        .select('players.*, topic_results.points AS total_points')
        .order('total_points DESC')
    end

    def order_by_weekly_topic(topic)
      joins(:topic_results)
        .where('topic_id = ?', topic.id)
        .recent_results
        .select('players.*, topic_results.weekly_points AS total_points')
        .order('total_points DESC')
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
