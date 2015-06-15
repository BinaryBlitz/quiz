class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.belongs_to :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
