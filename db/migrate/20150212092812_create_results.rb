class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :points
      t.references :player, index: true, null: false
      t.references :topic, index: true

      t.timestamps null: false
    end
    add_foreign_key :results, :players
    add_foreign_key :results, :topics
  end
end
