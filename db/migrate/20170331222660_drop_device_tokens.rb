class DropDeviceTokens < ActiveRecord::Migration[5.0]
  def change
    Player.find_each do |player|
      device_token = player.device_tokens.last
      next unless device_token.present?
      player.update(device_token: device_token.token)
    end
    drop_table :device_tokens
  end
end
