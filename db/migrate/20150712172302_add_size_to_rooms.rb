class AddSizeToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :size, :integer
  end
end
