# Encapsulates player and corresponding points value
class RoomSessionResult
  def initialize(question_results)
    @results = Hash.new(0)
    question_results.each { |answer| @results.add(answer[:player], answer[:points]) }
  end

  def rankings
    @results.sort_by { |_, value| value }.reverse
  end

  private

  def add(player, points)
    @results[player] += points
  end
end
