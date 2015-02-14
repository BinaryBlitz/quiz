require 'rails_helper'

describe 'GET /categories' do
  it 'returns a category and its topics by :id' do
    topic = create(:topic)
    category = create(:category)
    player = create(:player)

    get "/categories/#{category.id}", token: player.token

    debugger
    expect(response_json).to eq(
      {
        'id': category.id,
        'name': category.name
      }
    )
  end
end
