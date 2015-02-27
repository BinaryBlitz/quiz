class AddVkTokenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :vk_token, :string
    add_column :players, :vk_id, :integer
  end
end
