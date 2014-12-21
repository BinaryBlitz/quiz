require 'rails_helper'

RSpec.describe Question, :type => :model do
  before do
    @question = FactoryGirl.create(:question)
  end

  it "should not be valid without content" do
    @question.content = ''
    expect(@question).not_to be_valid
  end

  it "should not be valid with negative bounty" do
    @question.bounty = -1
    expect(@question).not_to be_valid
  end

  it "should noy be valid without topic" do
    @question.topic = nil
    expect(@question).not_to be_valid
  end
end
