require 'test_helper'

class PushTokensTest < ActionDispatch::IntegrationTest
  def setup
    @player = players(:foo)
  end

  test 'should create push token' do
    push_token = 'foobar'

    post "/api/push_tokens", token: token, push_token: push_token
    assert_response :created
    assert_equal push_token, @player.push_tokens.last.token

    post "/api/push_tokens", token: token, push_token: push_token
    assert_response :unprocessable_entity
  end

  test 'should create Android push token' do
    post "/api/push_tokens", token: token, push_token: 'foobar', android: 'true'
    assert_response :created
    assert_equal 'foobar', @player.push_tokens.last.token
    assert @player.push_tokens.last.android?
  end

  test 'should replace push token' do
    old_token = 'foobar'
    new_token = 'new token'

    post "/api/push_tokens", token: token, push_token: old_token
    patch "/api/push_tokens/replace", token: token, old_token: old_token, new_token: new_token

    assert_response :success
    assert_nil @player.push_tokens.find_by(token: old_token)
    assert_equal new_token, @player.push_tokens.last.token

    patch "/api/push_tokens/replace", token: token, old_token: 'invalid', new_token: new_token
    assert_response :unprocessable_entity
  end

  test 'should destroy push token' do
    push_token = 'foobar'
    post "/api/push_tokens", token: token

    # delete :delete, token: token
    # assert_response :no_content
  end
end
