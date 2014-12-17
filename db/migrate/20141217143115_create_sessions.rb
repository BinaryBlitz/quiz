class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :player, index: true
      t.integer :opponent_id

      t.timestamps null: false
    end
    add_foreign_key :sessions, :players
  end
end
