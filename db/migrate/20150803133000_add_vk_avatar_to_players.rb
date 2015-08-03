class AddVkAvatarToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :vk_avatar, :string
  end
end
