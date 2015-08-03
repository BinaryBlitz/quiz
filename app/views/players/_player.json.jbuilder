json.extract! player, :id, :username, :email, :avatar_url

json.avatar_url player.vk_avatar_url || player.avatar_url
json.avatar_thumb_url player.avatar.thumb.url

json.is_online player.online?
