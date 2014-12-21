require 'rails_helper'

RSpec.describe SessionQuestion, :type => :model do
  before do
    @sq = FactoryGirl.create(:session_question)
  end

  it "should not be valid without session" do
    @sq.session = nil
    expect(@sq).not_to be_valid
  end

  it "should not be valid without question" do
    @sq.question = nil
    expect(@sq).not_to be_valid
  end
end
