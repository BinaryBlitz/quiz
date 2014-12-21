# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

host = Player.create(name: 'Foo', email: 'foo@bar.com', password_digest: BCrypt::Password.create('foobar'))
opponent = Player.create(name: 'Bar', email: 'bar@foo.com', password_digest: BCrypt::Password.create('barfoo'))

category = Category.create(name: 'General')
topic = Topic.create(name: 'Geography', category: category)

question_1 = Question.create(content: 'Capital of the UK', topic: topic)
question_2 = Question.create(content: 'Test question', topic: topic)

answer_1 = Answer.create(content: 'London', correct: true, question: question_1)
answer_2 = Answer.create(content: 'New York', question: question_1)
answer_3 = Answer.create(content: 'Paris', question: question_1)
answer_4 = Answer.create(content: 'Berlin', question: question_1)

session = Session.create(host: host, opponent: opponent)
sq_1 = SessionQuestion.create(session: session, question: question_1,
  host_answer: answer_1, opponent_answer: answer_2)
sq_2 = SessionQuestion.create(session: session, question: question_2,
  host_answer: answer_3, opponent_answer: answer_4)