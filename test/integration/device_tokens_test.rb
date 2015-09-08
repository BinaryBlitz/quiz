require 'test_helper'

class DeviceTokensTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
    @device_token = device_tokens(:apple)
  end

  test 'create' do
    device_token = 'foobar'

    assert_difference 'DeviceToken.count' do
      post '/api/device_tokens', token: token, device_token: { token: device_token, platform: 'ios' }
    end
    assert_response :created
  end

  test 'uniqueness' do
    assert_no_difference 'DeviceToken.count' do
      post '/api/device_tokens', token: token, device_token: {
        token: @device_token.token, platform: @device_token.platform
      }
    end
    assert_response :created
  end

  test 'create android token' do
    assert_difference 'DeviceToken.count' do
      post '/api/device_tokens', token: token, device_token: { token: 'foobar', platform: 'android' }
    end
    assert_response :created
  end

  test 'destroy' do
    post '/api/device_tokens', token: token, device_token: @device_token.token
  end
end
