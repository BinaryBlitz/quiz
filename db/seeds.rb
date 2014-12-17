# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

player = Player.create(name: 'Foo', email: 'foo@bar.com', password_digest: BCrypt::Password.create('foobar'))
opponent = Player.create(name: 'Bar', email: 'bar@foo.com', password_digest: BCrypt::Password.create('barfoo'))

question_1 = Question.create(text: 'Capital of the UK', answers: ['London', 'New York', 'Paris', 'Berlin'], correct_answer: 'London')
question_2 = Question.create(text: 'Test question', answers: ['Foo', 'Bar', 'Baz', 'Qux'], correct_answer: 'Foo')

session = Session.create(player: player, opponent: opponent)
sq_1 = SessionQuestion.create(session: session, question: question_1)
sq_2 = SessionQuestion.create(session: session, question: question_2)