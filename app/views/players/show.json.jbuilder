json.extract! @player, :id, :name, :email, :api_key
json.api_key @player.api_key.to_s
