require 'test_helper'

class TopicsTest < ActionDispatch::IntegrationTest
  def setup
    @topic = topics(:geography)
  end

  test 'should show topic' do
    get "/api/topics/#{@topic.id}", params: { token: token }
    assert_response :success
    assert_equal @topic.name, json_response[:name]
  end
end
