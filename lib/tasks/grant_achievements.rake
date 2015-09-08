task grant_achievements: :environment do
  category_badges = Merit::Badge.all.select { |badge| badge.custom_fields && badge.custom_fields[:category_name] }
  category_badges.each do |category_badge|
    category = Category.find_by(name: category_badge.custom_fields[:category_name])
    next unless category

    top_players = Player.order_by_weekly_category(category).limit(10)
    Player.all.each do |player|
      if top_players.include?(player)
        player.add_badge(category_badge.id)
        player.push_achievement(category_badge)
      end
    end
  end
end
