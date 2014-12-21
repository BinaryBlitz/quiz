require 'rails_helper'

RSpec.describe Session, :type => :model do
  before do
    @session = FactoryGirl.create(:session)
  end

  it "should not be valid without host" do
    @session.host = nil
    expect(@session).not_to be_valid
  end
end
