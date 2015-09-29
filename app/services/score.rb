class Score
  def initialize(player)
    @player = player
  end

  def points(weekly = false)
    if weekly
      @player.recent_topic_results.sum(:weekly_points)
    else
      @player.topic_results.sum(:points)
    end
  end

  def topic_points(topic, weekly = false)
    if weekly
      @player.recent_topic_results.find_by(topic: topic).weekly_points rescue 0
    else
      @player.topic_results.find_by(topic: topic).points rescue 0
    end
  end

  def category_points(category, weekly = false)
    if weekly
      @player.recent_topic_results.where(category: category).sum(:weekly_points)
    else
      @player.topic_results.where(category: category).sum(:points)
    end
  end

  def wins
    @wins ||= @player.topic_results.sum(:wins)
  end

  def draws
    @draws ||= @player.topic_results.sum(:draws)
  end

  def losses
    @losses ||= @player.topic_results.sum(:losses)
  end
end
