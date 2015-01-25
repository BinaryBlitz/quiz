class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.integer :host_id, index: true
      t.integer :opponent_id, index: true
      t.boolean :offline, default: true

      t.timestamps null: false
    end
  end
end
