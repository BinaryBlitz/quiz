require 'test_helper'

class ProposalsTest < ActionDispatch::IntegrationTest
  setup do
    @question = questions(:uk_capital)
    @answers = @question.answers
  end

  test 'create' do
    answers = @answers.map(&:content)
    assert_difference 'Proposal.count' do
      post '/api/proposals.json', params: {
        token: token,
        proposal: { content: @question.content, topic_id: @question.topic_id, answers: answers}
      }
      assert_response :created
    end
  end
end
