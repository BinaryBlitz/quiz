module Achievements
  extend ActiveSupport::Concern

  def erudite?
    Topic.all.each do |topic|
      topic_sessions = game_sessions.where(topic: topic)

      # Not erudite if there're no games played
      return false if topic_sessions.empty?

      # Find at least 1 win
      at_least_one_win = false
      topic_sessions.each do |game_session|
        if game_session.winner?(self)
          # Found a win, go to next topic
          at_least_one_win = true
          break
        end
      end

      # Not erudite
      return false unless at_least_one_win
    end
    true
  end
end
