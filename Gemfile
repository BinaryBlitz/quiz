source 'https://rubygems.org'

ruby '~> 2.4.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.8'
# Use sqlite3 as the database for Active Record
gem 'pg', '~> 0.19'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster.
gem 'turbolinks'
# Build JSON APIs with ease.
gem 'jbuilder', '~> 2.5'

# Front-end
gem 'slim-rails'
gem 'bootstrap-sass', '~> 3.3'
gem 'nested_form_fields', '~> 0.8'
gem 'kaminari', '~> 0.17'

# Auth
gem 'devise', '~> 4.2'
gem 'bcrypt'
gem 'has_secure_token'
gem 'pundit', '~> 1.1'

# Image processing
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-base64', '~> 2.5'
gem 'mini_magick', '~> 4.3'

# Utilities
gem 'pusher', '~> 0.18'
gem 'vkontakte_api', '~> 1.4'
gem 'merit', '~> 2.4'
gem 'rpush', '~> 2.5.0'
gem 'semantic', '~> 1.6'
gem 'ffaker', '~> 2.4'
gem 'rollbar'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  # Pry
  gem 'pry-rails'
  gem 'traceroute'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'annotate'
end

group :test do
  gem 'mocha'
end

group :production do
  # AWS adapter for CarrierWave
  gem 'fog-aws', '~> 1.2'
end
