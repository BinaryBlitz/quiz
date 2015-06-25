class RoomSessionResult
  def initialize
    @results = Hash.new(0)
  end

  def add(player, points)
    @results[player] += points
  end

  def rankings
    @results.sort_by { |_, v| v }.reverse!
  end
end
