# Players
host = Player.create!(username: 'foo', email: 'foo@bar.com', password: 'foobar')
opponent = Player.create!(username: 'baz', email: 'baz@qux.com', password: 'bazqux')
host.update!(token: 'foo')
opponent.update!(token: 'baz')

# Push notifications
app = Rpush::Apns::App.new
app.name = 'ios_app'
app.certificate = File.read(Rails.root.join('config', 'pushcert.pem'))
app.environment = 'sandbox'
app.connections = 1
app.save!

app = Rpush::Gcm::App.new
app.name = 'android_app'
app.auth_key = Rails.application.secrets.gcm_sender_id || 'gcm_sender_id'
app.connections = 1
app.save!

# Purchases
PurchaseType.create!(
  [{ identifier: 'booster-x2', multiplier: 2 }, { identifier: 'booster-x3', multiplier: 3 }]
)

# Admin
Admin.create(email: 'foo@bar.com', password: 'qwerty123', password_confirmation: 'qwerty123')

# Populate
Rake::Task['db:populate'].invoke
