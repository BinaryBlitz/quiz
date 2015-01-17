class RemoveDefaultValueForAnswerTime < ActiveRecord::Migration
  def change
    change_column_default(:game_session_questions, :host_time, nil)
    change_column_default(:game_session_questions, :opponent_time, nil)
  end
end
