# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Players
host = Player.create(name: 'Foo', email: 'foo@bar.com', password_digest: BCrypt::Password.create('foobar'))
opponent = Player.create(name: 'Bar', email: 'bar@foo.com', password_digest: BCrypt::Password.create('barfoo'))

# Categories and topics
category = Category.create(name: 'General')
topic = Topic.create(name: 'Geography', category: category)

# Questions
q1 = Question.create(content: 'What is the capital of the UK?', topic: topic)
q1.answers << Answer.create(content: 'London', correct: true)
q1.answers << Answer.create(content: 'New York')
q1.answers << Answer.create(content: 'Paris')
q1.answers << Answer.create(content: 'Berlin')

q2 = Question.create(content: 'What is the capital of the US?', topic: topic)
q2.answers << Answer.create(content: 'Washington D.C.', correct: true)
q2.answers << Answer.create(content: 'New York City')
q2.answers << Answer.create(content: 'Los Angeles')
q2.answers << Answer.create(content: 'Chicago')

q3 = Question.create(content: 'What is the largest country in the world?', topic: topic)
q3.answers << Answer.create(content: 'Russia', correct: true)
q3.answers << Answer.create(content: 'Canada')
q3.answers << Answer.create(content: 'United States')
q3.answers << Answer.create(content: 'Brazil')

q4 = Question.create(content: 'What is the largest country in Europe?', topic: topic)
q4.answers << Answer.create(content: 'Russia', correct: true)
q4.answers << Answer.create(content: 'Germany')
q4.answers << Answer.create(content: 'Poland')
q4.answers << Answer.create(content: 'The United Kingdom')

q5 = Question.create(content: 'What is the largest country in Americas?', topic: topic)
q5.answers << Answer.create(content: 'Canada', correct: true)
q5.answers << Answer.create(content: 'The United States')
q5.answers << Answer.create(content: 'Mexico')
q5.answers << Answer.create(content: 'Brazil')

q6 = Question.create(content: 'What is the largest country in Africa?', topic: topic)
q6.answers << Answer.create(content: 'Algeria', correct: true)
q6.answers << Answer.create(content: 'Egypt')
q6.answers << Answer.create(content: 'South African Republic')
q6.answers << Answer.create(content: 'Ghana')

q7 = Question.create(content: 'What is the largest country in Asia?', topic: topic)
q7.answers << Answer.create(content: 'Russia', correct: true)
q7.answers << Answer.create(content: 'China')
q7.answers << Answer.create(content: 'India')
q7.answers << Answer.create(content: 'Japan')

# Online session
session = Session.create(host: host, opponent: opponent)
sq1 = SessionQuestion.create(session: session, question: q1,
  host_answer: q1.answers.first, opponent_answer: q1.answers.second)
sq2 = SessionQuestion.create(session: session, question: q2,
  host_answer: q2.answers.second, opponent_answer: q2.answers.first)
sq3 = SessionQuestion.create(session: session, question: q1,
  host_answer: q1.answers.first, opponent_answer: q1.answers.second)
sq4 = SessionQuestion.create(session: session, question: q2,
  host_answer: q2.answers.second, opponent_answer: q2.answers.first)
sq5 = SessionQuestion.create(session: session, question: q1,
  host_answer: q1.answers.first, opponent_answer: q1.answers.second)
sq6 = SessionQuestion.create(session: session, question: q2,
  host_answer: q2.answers.second, opponent_answer: q2.answers.first)

# OfflineSession
offline_session = Session.create(host: host, opponent: opponent, offline: true)
offline_session.session_questions << SessionQuestion.create(question: q1, opponent_answer: q1.answers.first)
offline_session.session_questions << SessionQuestion.create(question: q2, opponent_answer: q1.answers.second)
offline_session.session_questions << SessionQuestion.create(question: q3, opponent_answer: q1.answers.first)
offline_session.session_questions << SessionQuestion.create(question: q4, opponent_answer: q1.answers.second)
offline_session.session_questions << SessionQuestion.create(question: q5, opponent_answer: q1.answers.first)
offline_session.session_questions << SessionQuestion.create(question: q6, opponent_answer: q1.answers.second)