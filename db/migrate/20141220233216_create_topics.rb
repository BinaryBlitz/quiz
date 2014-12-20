class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :name
      t.boolean :visible, default: false
      t.date :expires_at
      t.integer :price, default: 0
      t.integer :played_count, default: 0
      t.references :category, index: true

      t.timestamps null: false
    end
    add_foreign_key :topics, :categories
  end
end
