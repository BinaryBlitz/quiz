require 'test_helper'

class ReportsTest < ActionDispatch::IntegrationTest
  test 'create' do
    question = questions(:uk_capital)

    assert_difference 'Report.count' do
      post '/api/reports/', token: token, message: 'Typo', question_id: question.id
      assert_response :created
    end
  end
end
