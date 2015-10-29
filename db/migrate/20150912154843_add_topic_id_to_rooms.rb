class AddTopicIdToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :topic, index: true
  end
end
