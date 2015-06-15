class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.belongs_to :player, index: true, foreign_key: true
      t.belongs_to :room, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :participations, [:player_id, :room_id], unique: true
  end
end
