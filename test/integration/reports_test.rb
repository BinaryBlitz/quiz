require 'test_helper'

class ReportsTest < ActionDispatch::IntegrationTest
  test 'create' do
    question = questions(:capital_of_the_uk)

    assert_difference 'Report.count' do
      post '/api/reports/', token: token, message: 'Typo', question_id: question.id
      assert_response :created
    end
  end
end
