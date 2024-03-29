class Leaderboard
  attr_reader :rankings
  attr_reader :position
  attr_reader :points

  SIZE = 20

  def initialize(player, options = {})
    @player = player

    @weekly = options[:weekly]
    @topic = options[:topic]
    @category = options[:category]
    @friends = options[:friends]
    build
  end

  private

  def build
    @rankings = build_rankings
    @position = player_position
  end

  def player_position
    return nil if @friends

    @points = player_points
    return nil if @points == 0

    rankings = generic_rankings
    rankings = rankings.where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week) if @weekly
    generic_rankings.limit(nil).having("#{total_points} > ?", @points).count.size
  end

  def player_points
    score = Score.new(@player)
    if @topic
      score.topic_points(@topic, @weekly)
    elsif @category
      score.category_points(@category, @weekly)
    else
      score.points(@weekly)
    end
  end

  def build_rankings
    rankings = select_points(generic_rankings)
    rankings.order("total_points DESC")
  end

  def generic_rankings
    rankings = player_rankings
    rankings = topic(rankings) if @topic
    rankings = category(rankings) if @category
    rankings = weekly(rankings) if @weekly
    rankings = friends(rankings) if @friends
    rankings
  end

  def player_rankings
    limit = @friends ? nil : SIZE
    Player.joins(:topic_results).limit(limit).group('players.id')
  end

  def weekly(rankings)
    rankings.where('topic_results.updated_at > ?', Time.zone.now.beginning_of_week)
  end

  def select_points(rankings)
    rankings.select("players.*, #{total_points} AS total_points")
  end

  def total_points
    type = @weekly ? 'weekly_points' : 'points'
    "SUM(topic_results.#{type})"
  end

  def topic(rankings)
    rankings.where('topic_results.topic_id' => @topic)
  end

  def category(rankings)
    rankings.where('topic_results.category_id' => @category)
  end

  def friends(rankings)
    ids = @player.friends.ids << @player.id
    rankings.where('topic_results.player_id' => ids)
  end
end
