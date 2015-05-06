# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Players
host = Player.create(
  name: 'Foo', username: 'foo', email: 'foo@bar.com', password: 'foobar')
opponent = Player.create(
  name: 'Bar', username: 'bar', email: 'bar@foo.com', password: 'barfoo')
# API keys
host.update(token: 'foobar')
opponent.update(token: 'barfoo')
# Push tokens
host.push_tokens.create(token: 'apple')
host.push_tokens.create(token: 'android', android: true)
opponent.push_tokens.create(token: 'apple-2')
opponent.push_tokens.create(token: 'android-2', android: true)

# Purchases
PurchaseType.create(
  [{ identifier: 'booster-x2', multiplier: 2 }, { identifier: 'booster-x3', multiplier: 3 }])

# Categories and topics
category = Category.create(name: 'General')
topic = Topic.create(name: 'Geography', category: category)

# Questions
questions = {
  'What is the capital of the UK?': %w(London New\ York\ City Paris Berlin),
  'What is the capital of the US?': %w(Washington\ D.C. New\ York\ City Los\ Angeles Chicago),
  'What is the largest country in the world?': %w(Russia Canada The\ United\ States Brazil),
  'What is the largest country in Europe?': %w(Russia Germany Poland The\ United\ Kingdom),
  'What is the largest country in Americas?': %w(Canada The\ United\ States Mexico Brazil),
  'What is the largest country in Africa?': %w(Algeria Egypt South\ African\ Republic Ghana),
  'What is the largest country in Asia?': %w(Russia China India Japan)
}

questions.each do |question, answers|
  q = Question.new(content: question, topic: topic)
  answers.each { |answer| q.answers.new(content: answer, correct: answer == answers.first) }
  q.save
end

# Online and offline session
GameSession.create(host: host, opponent: opponent, topic: topic, offline: false)
offline_session = GameSession.create(host: host, topic: topic, offline: true)
offline_session.game_session_questions.each do |session_question|
  session_question.update!(host_answer: session_question.question.correct_answer, host_time: 1)
end

# Admin
Admin.create(
  email: 'foo@bar.com',
  password: 'qwerty123', password_confirmation: 'qwerty123')
