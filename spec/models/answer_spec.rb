require 'rails_helper'

RSpec.describe Answer, :type => :model do
  before do
    @answer = FactoryGirl.create(:answer)
  end

  it "should not be valid without content" do
    @answer.content = ''
    expect(@answer).not_to be_valid
  end
end
