task weekly_achievements: :environment do
  Rails.logger.debug "Granting category achievements"
  grant_category_achievements
  Rails.logger.debug "Granting topic achievements"
  grant_topic_achievements
end

def grant_category_achievements
  badges = Merit::Badge.all.select { |badge| category_badge?(badge) }
  badges.each do |badge|
    category = Category.find_by(name: badge.custom_fields[:category_name])
    unless category
      Rails.logger.debug "Category not found: #{badge.custom_fields[:category_name]}"
      next
    end


    Rails.logger.debug('Granting category achievements')
    top_players = Player.order_by_weekly_category(category).limit(10)
    top_players.each do |player|
      player.add_badge(badge.id) unless player.badges.include?(badge)
    end
  end
end

def grant_topic_achievements
  badges = Merit::Badge.all.select { |badge| topic_badge?(badge) }
  badges.each do |badge|
    topic = Topic.find_by(name: badge.custom_fields[:topic_name])
    unless topic
      Rails.logger.debug "Topic not found: #{badge.custom_fields[:topic_name]}"
      next
    end

    top_players = Player.order_by_weekly_topic(topic).limit(10)
    top_players.each do |player|
      player.add_badge(badge.id) unless player.badges.include?(badge)
    end
  end
end

def category_badge?(badge)
  badge.custom_fields && badge.custom_fields[:category_name]
end

def topic_badge?(badge)
  badge.custom_fields && badge.custom_fields[:topic_name]
end
