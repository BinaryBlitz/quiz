class CreateTopicResults < ActiveRecord::Migration
  def change
    create_table :topic_results do |t|
      t.belongs_to :player, index: true
      t.belongs_to :topic, index: true
      t.integer :points, default: 0
      t.integer :weekly_points, default: 0

      t.timestamps null: false
    end
    add_foreign_key :topic_results, :players
    add_foreign_key :topic_results, :topics
  end
end
