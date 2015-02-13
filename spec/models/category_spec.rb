# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  before { @category = build(:category) }
  it { should validate_presence_of(:name) }
end

describe Category, 'Associations' do
  it { should have_many(:topics) }
end
