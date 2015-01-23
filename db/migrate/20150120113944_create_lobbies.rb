class CreateLobbies < ActiveRecord::Migration
  def change
    create_table :lobbies do |t|
      t.integer :query_count, default: 0
      t.boolean :closed, default: false
      t.references :topic, index: true
      t.references :player, index: true

      t.timestamps null: false
    end
    add_foreign_key :lobbies, :topics
    add_foreign_key :lobbies, :players
  end
end
