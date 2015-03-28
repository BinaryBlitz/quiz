require 'test_helper'

class PushTokensControllerTest < ActionController::TestCase
  def setup
    @player = players(:foo)
  end

  test 'should create push token' do
    push_token = 'foobar'

    post :create, token: token, format: :json, push_token: push_token
    assert_response :created
    assert_equal push_token, @player.push_tokens.last.token

    post :create, token: token, format: :json, push_token: push_token
    assert_response :unprocessable_entity
  end

  test 'should create Android push token' do
    post :create, token: token, format: :json, push_token: 'foobar', android: 'true'
    assert_response :created
    assert_equal 'foobar', @player.push_tokens.last.token
    assert @player.push_tokens.last.android?
  end

  test 'should replace push token' do
    old_token = 'foobar'
    new_token = 'new token'

    post :create, token: token, format: :json, push_token: old_token
    patch :replace, token: token, format: :json, old_token: old_token, new_token: new_token

    assert_response :success
    assert_nil @player.push_tokens.find_by(token: old_token)
    assert_equal new_token, @player.push_tokens.last.token

    patch :replace, token: token, format: :json, old_token: 'invalid', new_token: new_token
    assert_response :unprocessable_entity
  end

  test 'should destroy push token' do
    push_token = 'foobar'
    post :create, token: token, format: :json, push_token: push_token

    delete :delete, token: token, format: :json, push_token: push_token
    assert_response :no_content

    delete :delete, token: token, format: :json, push_token: push_token
    assert_response :not_found
  end
end
