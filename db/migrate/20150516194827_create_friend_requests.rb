class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.references :player, index: true, foreign_key: true
      t.references :friend, index: true

      t.timestamps null: false
    end
    add_index :friend_requests, [:player_id, :friend_id], unique: true
  end
end
