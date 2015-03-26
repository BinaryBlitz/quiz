# == Schema Information
#
# Table name: players
#
#  id              :integer          not null, primary key
#  name            :string
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  imei            :string
#  points          :integer          default(0)
#  weekly_points   :integer          default(0)
#  vk_token        :string
#  vk_id           :integer
#  sash_id         :integer
#  level           :integer          default(0)
#  avatar          :string
#

require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def setup
    @foo = players(:foo)
    @bar = players(:bar)
    @vk_player = players(:vk_player)
  end

  test 'invalid without name' do
    @foo.name = ''
    assert @foo.invalid?
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
    @foo.password_digest = ''
    assert @foo.invalid?
  end

  test 'should allow empty password if vk ' do
    @vk_player.password_digest = ''
    assert @vk_player.valid?
  end
end
