class AddTopicToRooms < ActiveRecord::Migration
  def change
    add_reference :rooms, :topic, index: true, foreign_key: true
  end
end
