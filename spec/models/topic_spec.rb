require 'rails_helper'

RSpec.describe Topic, :type => :model do
  before do
    @topic = FactoryGirl.create(:topic)
  end

  it "should not be valid without name" do
    @topic.name = ''
    expect(@topic).not_to be_valid
  end

  it "should not be valid when price is negative" do
    @topic.price = -1
    expect(@topic).not_to be_valid
  end

  it "should not be valid when played count is negative" do
    @topic.played_count = -1
    expect(@topic).not_to be_valid
  end

  it "should not be valid without category" do
    @topic.category = nil
    expect(@topic).not_to be_valid
  end
end
