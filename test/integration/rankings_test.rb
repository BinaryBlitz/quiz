require 'test_helper'

class RankingsTest < ActionDispatch::IntegrationTest
  test 'should get rankings' do
    get '/api/rankings/general', token: token
    assert_response :success
  end

  test 'should get weekly rankings' do
    get '/api/rankings/general', token: token, weekly: true
    assert_response :success
  end

  test 'should get topic rankings' do
    topic = Topic.first
    get '/api/rankings/topic', token: token, topic_id: topic.id
    assert_response :success
  end

  test 'should get category rankings' do
    category = Category.first
    get '/api/rankings/category', token: token, category_id: category.id
    assert_response :success
  end
end
