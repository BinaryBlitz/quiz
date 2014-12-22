# == Schema Information
#
# Table name: sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  online      :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

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
