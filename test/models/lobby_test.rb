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

require 'test_helper'

class LobbyTest < ActiveSupport::TestCase
  def setup
    @lobby = lobbies(:lobby)
  end

  test 'close' do
    @lobby.close
    assert @lobby.closed?
  end
end
