class CreateCategoryResults < ActiveRecord::Migration
  def change
    create_table :category_results do |t|
      t.belongs_to :player, index: true
      t.belongs_to :category, index: true
      t.integer :points, default: 0
      t.integer :weekly_points, default: 0

      t.timestamps null: false
    end
    add_foreign_key :category_results, :players
    add_foreign_key :category_results, :categories
  end
end
