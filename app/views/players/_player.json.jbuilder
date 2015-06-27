json.extract! player, :id, :username, :email, :avatar_url
json.is_online player.online?
