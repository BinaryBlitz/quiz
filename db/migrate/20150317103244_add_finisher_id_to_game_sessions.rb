class AddFinisherIdToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :finisher_id, :integer
    add_index :game_sessions, :finisher_id
  end
end
