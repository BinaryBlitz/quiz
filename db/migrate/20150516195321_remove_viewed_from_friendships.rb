class RemoveViewedFromFriendships < ActiveRecord::Migration
  def change
    remove_column :friendships, :viewed, :boolean
  end
end
