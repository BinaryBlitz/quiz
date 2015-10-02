json.partial! 'player', player: @player

json.is_friend current_player.friends.include?(@player)

json.cache! "players/#{@player.id}-total_score", expires_in: 5.minutes do
  # TODO: Rename to score?
  json.total_score do
    json.wins @player.score.wins
    json.draws @player.score.draws
    json.losses @player.score.losses
  end
end

json.cache! "players/#{@player.id}-#{current_player.id}", expires_in: 5.minutes do
  unless @player == current_player
    score = current_player.score.against(@player)
    json.score do
      json.wins score.wins
      json.losses score.losses
    end
  end
end

json.favorite_topics @player.favorite_topics do |topic|
  json.partial! 'topics/topic', topic: topic
end

json.achievements do
  json.array! @player.badges do |achievement|
    json.partial! 'achievements/achievement', achievement: achievement
  end
end
