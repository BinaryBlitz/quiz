# == Schema Information
#
# Table name: players
#
#  id                     :integer          not null, primary key
#  email                  :string
#  password_digest        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  vk_token               :string
#  vk_id                  :integer
#  sash_id                :integer
#  level                  :integer          default(0)
#  avatar                 :string
#  username               :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  token                  :string
#  xmpp_password          :string
#  visited_at             :datetime
#  vk_avatar              :string
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @foo = players(:foo)
    @bar = players(:bar)
    @vk_player = players(:vk_player)
  end

  test 'valid without email' do
    player = Player.new(@foo.attributes)
    player.email = nil
    player.username = 'new'
    player.password = 'foobar'
    assert player.valid?
  end

  test 'should allow empty email' do
    @vk_player.email = nil
    assert @vk_player.valid?
  end

  test 'email uniqueness' do
    @bar.email = @foo.email
    assert @bar.invalid?
  end

  test 'email format' do
    invalid_emails = %w(foobar foo@bar.1com email.com @.email@bar.com)
    invalid_emails.each do |invalid_email|
      @foo.email = invalid_email
      assert @foo.invalid?
    end
  end

  test 'invalid without password' do
    @foo.password = nil
    assert @foo.invalid?
  end

  test 'invalid without username' do
    @foo.username = ''
    assert @foo.invalid?
  end

  test 'username uniqueness' do
    @bar.username = @foo.username
    assert @bar.invalid?
  end

  test 'case-insensitive uniqueness' do
    @bar.username = @foo.username.upcase
    assert @bar.invalid?
  end

  test 'search' do
    result = Player.search(@foo.username.downcase[0..-2])
    assert result.include?(@foo)
  end
end
