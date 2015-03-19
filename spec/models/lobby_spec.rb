# == Schema Information
#
# Table name: lobbies
#
#  id              :integer          not null, primary key
#  query_count     :integer          default(0)
#  closed          :boolean          default(FALSE)
#  topic_id        :integer
#  player_id       :integer
#  game_session_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  challenge       :boolean          default(FALSE)
#

require 'rails_helper'

RSpec.describe Lobby, type: :model do
  before { @lobby = build(:lobby) }

  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:player) }

  it 'should properly close itself' do
    @lobby.close
    expect(@lobby.closed?).to be true
  end
end

describe Lobby, 'Associations' do
  it { should belong_to(:topic) }
  it { should belong_to(:player) }
  it { should belong_to(:game_session) }
end
