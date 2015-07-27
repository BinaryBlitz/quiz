class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.belongs_to :creator, index: true
      t.belongs_to :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end