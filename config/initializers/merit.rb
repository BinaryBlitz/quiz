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

id = 0
badges = [
  { id: id += 1, name: 'Победитель', description: 'Win 100 games.' },
  { id: id += 1, name: 'Верный делу', description: 'Play 10 days in a row.' },
  { id: id += 1, name: 'Молния', description: 'Answer all questions in 12 seconds or less.' },
  { id: id += 1, name: 'Эрудит', description: 'At least 1 win in all topics.' },
  { id: id += 1, name: 'Суперкомпьютер', description: 'Win 50 games ahead of time.' },
  { id: id += 1, name: 'Дружелюбный', description: 'Add a friend.' },
  {
    id: id += 1, name: 'Колумб', description: 'Топ в географии.',
    custom_fields: { category_name: 'География' }
  },
  {
    id: id += 1, name: 'Чайковский', description: 'Топ в музыке.',
    custom_fields: { category_name: 'Музыка' }
  },
  {
    id: id += 1, name: 'Яшин', description: 'Топ в спорте.',
    custom_fields: { category_name: 'Спорт' }
  },
  {
    id: id += 1, name: 'Ломоносов', description: 'Топ в образовании.',
    custom_fields: { category_name: 'Образование' }
  },
  {
    id: id += 1, name: 'Геродот', description: 'Топ в истории.',
    custom_fields: { category_name: 'История' }
  }
]

badges.each do |attrs|
  Merit::Badge.create!(attrs)
end
