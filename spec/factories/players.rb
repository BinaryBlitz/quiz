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
