ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/pride'
require 'mocha/mini_test'

app = Rpush::Apns::App.new(name: 'ios_app', environment: 'sandbox', connections: 1)
app.certificate = 'test'
app.save

app = Rpush::Gcm::App.new(name: 'android_app', connections: 1)
app.auth_key = Rails.application.secrets.gcm_sender_id || 'gcm_sender_id'
app.save

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def token
    players(:foo).token
  end

  def json_response
    JSON.parse(@response.body, symbolize_names: true)
  end
end
