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
  { id: id += 1, name: 'Победитель', description: 'Выиграть 100 игр.' },
  { id: id += 1, name: 'Верный делу', description: '10 дней игры подряд.' },
  { id: id += 1, name: 'Молния', description: 'Ответить на все вопросы менее, чем за 12 секунд.' },
  { id: id += 1, name: 'Эрудит', description: 'По одной победе в каждой теме.' },
  { id: id += 1, name: 'Суперкомпьютер', description: '50 побед до окончания игры.' },
  { id: id += 1, name: 'Дружелюбный', description: 'Отправить запрос в друзья.' },
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
  },
  {
    id: id += 1, name: 'Патриот', description: 'Топ в регионах.',
    custom_fields: { category_name: 'Регионы' }
  },
  {
    id: id += 1, name: 'Шумахер', description: 'Топ в автомобилях.',
    custom_fields: { category_name: 'История' }
  },
  {
    id: id += 1, name: 'Зоолог', description: 'Топ в животных.',
    custom_fields: { category_name: 'Животные' }
  },
  {
    id: id += 1, name: 'Биограф', description: 'Топ в личностях.',
    custom_fields: { category_name: 'История' }
  },
  {
    id: id += 1, name: 'Рокер', description: 'Топ в теме: «Рок и метал»',
    custom_fields: { topic_name: 'Рок и метал' }
  },
  {
    id: id += 1, name: 'Джастин Бибер', description: 'Топ в теме: «Попса»',
    custom_fields: { topic_name: 'Попса' }
  },
  {
    id: id += 1, name: 'Гиппократ', description: 'Топ в теме: «Медицина и анатомия»',
    custom_fields: { topic_name: 'Медицина и анатомия' }
  },
  {
    id: id += 1, name: 'Полиглот', description: 'Топ в теме: «Значения слов»',
    custom_fields: { topic_name: 'Значения слов' }
  },
  {
    id: id += 1, name: 'Василий Уткин', description: 'Топ в теме: «Футбол»',
    custom_fields: { topic_name: 'Рок' }
  },
  {
    id: id += 1, name: 'Милитарист', description: 'Топ в теме: «Оружие и военная техника»',
    custom_fields: { topic_name: 'Оружие и военная техника' }
  },
  {
    id: id += 1, name: 'Анимешник', description: 'Топ в теме: «Аниме»',
    custom_fields: { topic_name: 'Аниме' }
  },
  {
    id: id += 1, name: 'Киноман', description: 'Топ в теме: «Современное кино»',
    custom_fields: { topic_name: 'Современное кино' }
  },
  {
    id: id += 1, name: 'Мультоман', description: 'Топ в теме: «Мультфильмы»',
    custom_fields: { topic_name: 'Мультфильмы' }
  },
  {
    id: id += 1, name: 'Шоумэн', description: 'Топ в теме: «Шоу-бизнес»',
    custom_fields: { topic_name: 'Шоу-бизнес' }
  }
]

badges.each do |attrs|
  Merit::Badge.create!(attrs)
end
