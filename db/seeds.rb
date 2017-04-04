# Players
host = Player.create!(username: 'foobar', email: 'foo@bar.com', password: 'foobar')
opponent = Player.create!(username: 'bazqux', email: 'baz@qux.com', password: 'bazqux')
host.update!(token: 'foobar')
opponent.update!(token: 'bazqux')

# Purchases
PurchaseType.create!(
  [
    { identifier: 'booster-x2', multiplier: 2 },
    { identifier: 'booster-x3', multiplier: 3 }
  ]
)

# Admin
Admin.create(
  email: 'foo@bar.com',
  password: 'qwerty123',
  password_confirmation: 'qwerty123'
)
