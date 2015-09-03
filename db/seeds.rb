# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Players
host = Player.new(username: 'foo', email: 'foo@bar.com', password: 'foobar').register
opponent = Player.new(username: 'bar', email: 'bar@foo.com', password: 'barfoo').register
# API keys
host.update(token: 'foo')
opponent.update(token: 'bar')

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

# Device tokens
host.device_tokens.create(token: 'apple', platform: 'ios')
host.device_tokens.create(token: 'android', platform: 'android')
opponent.device_tokens.create(token: 'apple-2', platform: 'ios')
opponent.device_tokens.create(token: 'android-2', platform: 'android')

# Purchases
PurchaseType.create(
  [{ identifier: 'booster-x2', multiplier: 2 }, { identifier: 'booster-x3', multiplier: 3 }])

# Categories and topics
category = Category.create(name: 'Тестовая категория')
topic = Topic.create(name: 'Тестовая тема', category: category)

# Questions
questions = {}
10.times do |n|
  questions["Вопрос #{n + 1}"] = %w(Lorem Ipsum Dolor Sit)
end

# Answers
questions.each do |question, answers|
  q = Question.new(content: question, topic: topic)
  answers.each { |answer| q.answers.new(content: answer, correct: answer == answers.first) }
  q.save
end

# Facts
5.times do |n|
  Fact.create(content: "Факт #{n + 1}")
end

# Online and offline session
GameSession.create(host: host, opponent: opponent, topic: topic, offline: false).generate
offline_session = GameSession.create(host: host, topic: topic, offline: true).generate
offline_session.game_questions.each do |session_question|
  session_question.update!(host_answer: session_question.question.correct_answer, host_time: 1)
end

# Admin
Admin.create(email: 'foo@bar.com', password: 'qwerty123', password_confirmation: 'qwerty123')
