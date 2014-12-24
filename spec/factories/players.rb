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
#

FactoryGirl.define do
  factory :player, aliases: [:host] do
    name "Host Player"
    email "host@player.com"
    password_digest BCrypt::Password.create('foobar')
  end

  factory :opponent, class: Player do
    name "Opponent Player"
    email "opponent@player.com"
    password_digest BCrypt::Password.create('bazqux')
  end
end