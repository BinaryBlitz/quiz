# == Schema Information
#
# Table name: topics
#
#  id           :integer          not null, primary key
#  name         :string
#  visible      :boolean          default(FALSE)
#  expires_at   :date
#  price        :integer          default(0)
#  played_count :integer          default(0)
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  before { @topic = create(:topic) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:category) }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:played_count).is_greater_than_or_equal_to(0) }
end

describe Topic, 'Associations' do
  it { should belong_to(:category) }
  it { should have_many(:questions) }
  it { should have_many(:game_sessions) }
  it { should have_many(:lobbies) }
end
