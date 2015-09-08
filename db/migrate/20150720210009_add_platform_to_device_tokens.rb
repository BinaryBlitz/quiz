class AddPlatformToDeviceTokens < ActiveRecord::Migration
  def change
    remove_column :device_tokens, :android
    add_column :device_tokens, :platform, :string
  end
end
