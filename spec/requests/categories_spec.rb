require 'rails_helper'

describe 'GET /categories' do
  it 'returns a category and its topics by :id' do
    topic = create(:topic)
    category = create(:category)
    player = create(:player)
    category.topics << topic

    get "/categories/#{category.id}", token: player.token

    expect(response_json).to eq(
      {
        id: category.id,
        name: category.name,
        topics: [{
          id: topic.id,
          name: topic.name,
          price: topic.price,
          played_count: topic.played_count
        }.stringify_keys]
      }.stringify_keys
    )
  end
end
