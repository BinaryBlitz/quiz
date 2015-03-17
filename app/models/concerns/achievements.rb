module Achievements
  extend ActiveSupport::Concern

  def wins
    count = 0
    game_sessions.each { |gs| count += 1 if gs.winner?(self) }
    count
  end
end
