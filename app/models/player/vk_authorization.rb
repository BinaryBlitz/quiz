module Player::VkAuthorization
  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create_from_vk(vk)
      user = vk.users.get(fields: [:photo_max_orig, :photo_medium]).first
      player = find_by(vk_id: user.uid)

      unless player
        player = create!(
          password: SecureRandom.hex,
          vk_token: vk.token, vk_id: user.uid,
          remote_avatar_url: user.photo_medium, remote_vk_avatar_url: user.photo_max_orig)
        add_friends(player, vk.friends.get)
      end
      player
    end

    private

    def format_name(user)
      "#{user.first_name} #{user.last_name}"
    end

    def add_friends(player, friends)
      friends.each do |friend_id|
        Rails.logger.debug "#{Time.zone.now}: Adding VK friend #{friend_id}"
        friend = Player.find_by(vk_id: friend_id)
        next unless friend
        player.friends << friend
      end
    end
  end
end
