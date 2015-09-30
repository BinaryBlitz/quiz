json.rankings do
  json.array! @leaderboard.rankings do |player|
    json.partial! 'player', player: player
  end
end

json.extract! @leaderboard, :position, :points
