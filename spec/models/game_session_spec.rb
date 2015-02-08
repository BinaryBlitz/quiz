# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default("false")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#

require 'rails_helper'

RSpec.describe GameSession, :type => :model do
  before do
    @session = create(:game_session)
  end

  it "should not be valid without host" do
    @session.host = nil
    expect(@session).not_to be_valid
  end

  it "should properly generate a session" do
    expect(@session.game_session_questions.count).to be > 0
    @session.game_session_questions.each do |sq|
      expect(sq.opponent_time).to be > 0
    end
  end
end
