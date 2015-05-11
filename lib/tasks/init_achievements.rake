desc 'Init achievements'
task init_achievements: :environment do
  if Merit::Badge.count != Achievement.count
    Merit::Badge.all.each { |badge| Achievement.create(badge_id: badge.id) }
  end
end
