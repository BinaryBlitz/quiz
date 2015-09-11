class AddPlatformToDeviceTokens < ActiveRecord::Migration
  def change
    remove_column :device_tokens, :android, :boolean
    add_column :device_tokens, :platform, :string
  end
end
