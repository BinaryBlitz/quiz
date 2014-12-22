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

RSpec.describe Category, :type => :model do
  before do
    @category = FactoryGirl.create(:category)
  end

  it "should not be valid without name" do
    @category.name = ''
    expect(@category).not_to be_valid
  end
end
