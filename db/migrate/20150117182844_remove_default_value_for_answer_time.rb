class RemoveDefaultValueForAnswerTime < ActiveRecord::Migration
  def self.up
    change_column_default(:game_session_questions, :host_time, nil)
    change_column_default(:game_session_questions, :opponent_time, nil)
  end

  def self.down
    change_column_default(:game_session_questions, :host_time, 0)
    change_column_default(:game_session_questions, :opponent_time, 0)
  end
end
