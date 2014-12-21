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
