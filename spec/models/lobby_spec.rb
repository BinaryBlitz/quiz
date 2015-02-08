# == Schema Information
#
# Table name: lobbies
#
#  id          :integer          not null, primary key
#  query_count :integer
#  topic_id    :integer
#  player_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Lobby, :type => :model do
  before do
    @lobby = build(:lobby)
  end

  it 'should not be valid without topic' do
    @lobby.topic = nil
    expect(@lobby).not_to be_valid
  end

  it 'should not be valid without player' do
    @lobby.player = nil
    expect(@lobby).not_to be_valid
  end

  it 'should properly close itself' do
    @lobby.close
    expect(@lobby.closed?).to be true
  end
end
