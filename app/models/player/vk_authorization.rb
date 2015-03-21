module Player::VkAuthorization

  extend ActiveSupport::Concern

  module ClassMethods
    def find_or_create_from_vk(vk)
      user = vk.users.get(fields: [:photo]).first
      player = find_by(vk_id: user.uid)

      if player
        player
      else
        create!(
          name: format_name(user),
          vk_token: vk.token, vk_id: user.uid, remote_avatar_url: user.photo)
      end
    end

    private

    def format_name(user)
      "#{user.first_name} #{user.last_name}"
    end
  end
end
