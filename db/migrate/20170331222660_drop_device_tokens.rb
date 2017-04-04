class DropDeviceTokens < ActiveRecord::Migration[5.0]
  def change
    drop_table :device_tokens
  end
end
