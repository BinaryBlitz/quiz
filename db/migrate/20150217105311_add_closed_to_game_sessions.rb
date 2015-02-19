class AddClosedToGameSessions < ActiveRecord::Migration
  def change
    add_column :game_sessions, :closed, :boolean
  end
end
