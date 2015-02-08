class AddFinishedToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :finished, :boolean, default: false
  end
end
