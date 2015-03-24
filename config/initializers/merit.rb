# Use this hook to configure merit parameters
Merit.setup do |config|
  # Check rules on each request or in background
  # config.checks_on_each_request = true

  # Define ORM. Could be :active_record (default) and :mongoid
  # config.orm = :active_record

  # Add application observers to get notifications when reputation changes.
  config.add_observer 'BadgeObserver'

  # Define :user_model_name. This model will be used to grand badge if no
  # `:to` option is given. Default is 'User'.
  config.user_model_name = 'Player'

  # Define :current_user_method. Similar to previous option. It will be used
  # to retrieve :user_model_name object if no `:to` option is given. Default
  # is "current_#{user_model_name.downcase}".
  config.current_user_method = 'current_player'
end

# Create application badges (uses https://github.com/norman/ambry)
# badge_id = 0
# [{
#   id: (badge_id = badge_id+1),
#   name: 'just-registered'
# }, {
#   id: (badge_id = badge_id+1),
#   name: 'best-unicorn',
#   custom_fields: { category: 'fantasy' }
# }].each do |attrs|
#   Merit::Badge.create! attrs
# end

[
  { id: 1, name: 'winner', description: 'Win 100 games.' },
  { id: 2, name: 'faithful', description: 'Play 10 days in a row.' },
  { id: 3, name: 'lightning', description: 'Answer all questions in 12 seconds or less.' },
  { id: 4, name: 'columbus', description: 'Top in Geography.', custom_fields: { topic_id: 1 } },
  { id: 5, name: 'erudite', description: 'At least 1 win in all topics.' },
  { id: 6, name: 'supercomputer', description: 'Win 50 games ahead of time.' },
  { id: 7, name: 'test-badge', description: 'Fuck you.' }
].each do |attrs|
  Merit::Badge.create!(attrs)
end
