class CreateRoomSessions < ActiveRecord::Migration
  def change
    create_table :room_sessions do |t|
      t.belongs_to :room, index: true, foreign_key: true
      t.boolean :closed, default: false

      t.timestamps null: false
    end
  end
end
