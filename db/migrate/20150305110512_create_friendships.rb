class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.belongs_to :player, index: true
      t.integer :friend_id

      t.timestamps null: false
    end
    add_foreign_key :friendships, :players
  end
end
