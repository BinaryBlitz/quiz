class RemoveTopicIdFromRooms < ActiveRecord::Migration
  def change
    remove_column :rooms, :topic_id, :integer
  end
end
