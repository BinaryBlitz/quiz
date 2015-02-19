# == Schema Information
#
# Table name: game_sessions
#
#  id          :integer          not null, primary key
#  host_id     :integer
#  opponent_id :integer
#  offline     :boolean          default("true")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  topic_id    :integer
#  finished    :boolean          default("false")
#  closed      :boolean
#

require 'rails_helper'

RSpec.describe GameSession, type: :model do
  before { @session = create(:game_session) }

  it { should validate_presence_of(:host) }

  it 'should properly generate a session' do
    expect(@session.game_session_questions.count).to be > 0
    @session.game_session_questions.each do |sq|
      expect(sq.opponent_time).to be > 0
    end
  end
end

describe GameSession, 'Associations' do
  it { should belong_to(:host) }
  it { should belong_to(:opponent) }
  it { should belong_to(:topic) }

  it { should have_many(:game_session_questions) }
  it { should have_many(:questions) }
  it { should have_many(:lobbies) }
end
