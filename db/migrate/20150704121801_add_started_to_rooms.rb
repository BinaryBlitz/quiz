class AddStartedToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :started, :boolean, default: false
  end
end
