require 'test_helper'

class SearchesTest < ActionDispatch::IntegrationTest
  test 'should return nil for short usernames' do
    get '/api/players/search', token: token, query: 'a'
    assert_response :success
    assert_empty json_response
  end
end
