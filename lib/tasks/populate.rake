namespace :db do
  task populate: :environment do
    populate_players
    populate_categories
    populate_topics
    populate_questions
    populate_facts
    populate_sessions
    populate_challenges
    populate_rooms
    populate_invites
    populate_friends
    populate_topic_results
  end

  def populate_players
    puts 'Populating players'
    6.times do
      Player.create!(
        email: email, username: FFaker::Internet.user_name,
        password: FFaker::Internet.password, remote_avatar_url: FFaker::Avatar.image,
      )
    end
  end

  def populate_categories
    puts 'Populating categories'
    2.times do
      category = Category.create!(
        name: FFaker::Food.fruit,
        remote_background_url: 'http://lorempixel.com/720/1080/food/',
        remote_banner_url: 'http://lorempixel.com/720/240/food/'
      )
    end
  end

  def populate_topics
    puts 'Populating topics'
    Category.all.each do |category|
      2.times do
        Topic.create!(
          name: FFaker::Food.vegetable,
          visible: random,
          paid: FFaker::Boolean.random,
          category: category
        )
      end
    end
  end

  def populate_questions
    puts 'Populating questions'
    Topic.all.each do |topic|
      2.times do
        question = Question.new(
          content: FFaker::BaconIpsum.sentence,
          remote_image_url: question_image,
          topic: topic
        )
        generate_answers_for(question)
        question.save!
      end
    end
  end

  def generate_answers_for(question)
    4.times do |i|
      question.answers.build(
        content: FFaker::BaconIpsum.word.capitalize,
        correct: i == 0, question: question
      )
    end
  end

  def populate_facts
    puts 'Populating facts'
    2.times do |n|
      Fact.create!(content: FFaker::BaconIpsum.sentence)
    end
  end

  def populate_sessions
    puts 'Populating sessions'
    2.times do
      host, opponent = random_players(2)
      session = GameSession.create!(
        host: host, opponent: opponent,
        topic: random_topic, offline: random, closed: random
      )
      generate_game_questions_for(session)
    end
  end

  def generate_game_questions_for(session)
    return if session.offline? && !session.closed?

    session.game_questions.each do |question|
      question.update!(
        host_answer: question.send(:generate_answer),
        host_time: question.send(:random_time)
      )

      unless session.offline?
        question.update!(
          opponent_answer: question.send(:generate_answer),
          opponent_time: question.send(:random_time)
        )
      end
    end
  end

  def populate_challenges
    puts 'Populating challenges'
    2.times do
      host, opponent = random_players(2)
      host.lobbies.build(topic: random_topic).challenge_player(opponent)
    end
  end

  def populate_rooms
    puts 'Populating rooms'
    2.times do
      room = Room.create!(
        player: random_player, topic: random_topic,
        friends_only: random, started: random, size: rand(3..5)
      )
    end
  end

  def populate_invites
    puts 'Populating invites'
    Room.visible.each do |room|
      invitee = random_player
      room.player.outgoing_invites.create(room: room, player: invitee)
    end
  end

  def populate_friends
    puts 'Populating friends'
    Player.all.each do |player|
      friends = random_players(6).where.not(id: player.id).to_a

      friends.pop(3) do |pending_friend|
        player.friend_requests.create(friend: pending_friend)
      end

      friends.each do |friend|
        player.friendships.create(friend: friend)
      end
    end
  end

  def populate_topic_results
    puts 'Populating topic results'
    Player.all.each do |player|
      topics = Topic.order('RANDOM()').limit(3)

      topics.each do |topic|
        player.topic_results.create!(
          topic: topic,
          points: rand(1000) + 1000,
          weekly_points: rand(1000),
          wins: rand(10), draws: rand(10), losses: rand(10), count: rand(30)
        )
      end
    end
  end

  # Helpers

  def email
    random ? FFaker::Internet.email : nil
  end

  def random_player
    Player.order('RANDOM()').first
  end

  def random_players(count)
    Player.order('RANDOM()').limit(count)
  end

  def random_topic
    Topic.order('RANDOM()').first
  end

  def question_image
    random ? 'http://lorempixel.com/500/500/food/' : nil
  end

  def random
    [true, false].sample
  end
end
