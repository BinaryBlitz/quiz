class CreateStats < ActiveRecord::Migration
  def change
    create_table :stats do |t|
      t.integer :days_in_a_row, default: 0
      t.date :played_at
      t.belongs_to :player, index: true

      t.timestamps null: false
    end
    add_foreign_key :stats, :players
  end
end
