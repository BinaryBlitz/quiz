json.extract! player, :id, :username, :email, :avatar_url

json.avatar_thumb_url player.avatar.thumb.url

json.is_online player.online?
