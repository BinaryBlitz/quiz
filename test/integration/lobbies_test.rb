require 'test_helper'

class LobbiesTest < ActionDispatch::IntegrationTest
  test 'authorize challenge topics' do
    paid_topic = topics(:paid)
    foo = players(:foo)
    baz = players(:baz)

    post "/api/lobbies/challenge", params: {
      token: foo.token, topic_id: paid_topic.id, opponent_id: baz.id
    }
    assert_response :forbidden
  end
end
