desc 'Calculate overall and weekly player points'
task update_rankings: :environment do
  players = Player.all
  players.each do |player|
    # Sum
    points = 0
    weekly_points = 0
    player.reset_weekly_points

    # Iterate through each session and calculate points
    player.game_sessions.each do |session|
      session_points = session.player_points(player)
      weekly_points += session_points if session.recent?
      points += session_points

      # Update topic points for given player
      topic_result = topic_results(player, session)
      topic_result.update!(
        points: topic_result.points + session_points,
        weekly_points: topic_result.weekly_points + session_points)
      # Update category points
      category_result = category_results(player, session)
      category_result.update!(
        points: category_result.points + session_points,
        weekly_points: category_result.weekly_points + session_points)
    end

    player.update!(points: points, weekly_points: weekly_points)
  end
end

# Get player topic results
def topic_results(player, session)
  player.topic_results.find_or_create_by(topic: session.topic)
end

def category_results(player, session)
  player.category_results.find_or_create_by(category: session.topic.category)
end
