class AddFriendsOnlyToRooms < ActiveRecord::Migration
  def change
    add_column :rooms, :friends_only, :boolean, default: false
  end
end
