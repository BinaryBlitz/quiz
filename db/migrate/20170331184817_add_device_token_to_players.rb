class AddDeviceTokenToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :device_token, :string
  end
end
