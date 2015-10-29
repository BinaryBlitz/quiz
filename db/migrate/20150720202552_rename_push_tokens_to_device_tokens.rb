class RenamePushTokensToDeviceTokens < ActiveRecord::Migration
  def change
    rename_table :push_tokens, :device_tokens
  end
end
