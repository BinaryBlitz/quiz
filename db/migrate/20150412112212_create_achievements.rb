class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :badge_id
      t.string :icon

      t.timestamps null: false
    end
  end
end
