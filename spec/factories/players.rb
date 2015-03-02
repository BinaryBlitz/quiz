# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  imei            :string
#  points          :integer          default("0")
#  weekly_points   :integer          default("0")
#  vk_token        :string
#  vk_id           :integer
#

FactoryGirl.define do
  factory :player, aliases: [:host] do
    name 'Host Player'
    email 'host@player.com'
    password_digest BCrypt::Password.create('foobar')
    api_key
  end

  factory :opponent, class: Player do
    name 'Opponent Player'
    email 'opponent@player.com'
    password_digest BCrypt::Password.create('bazqux')
    api_key { create_api_key }
  end
end
