task grant_achievements: :environment do
  topic_badges = Merit::Badge.all.select { |badge| badge.custom_fields && badge.custom_fields[:topic_id] }
  topic_badges.each do |topic_badge|
    topic = Topic.find_by(id: topic_badge.custom_fields[:topic_id])
    next unless topic
    top_players = Player.order_by_topic(topic).limit(10)
    Player.all.each do |player|
      if top_players.include?(player)
        player.add_badge(topic_badge)
      end
    end
  end
end
