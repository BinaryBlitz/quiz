class VKTest < ActiveSupport::TestCase
  def setup
    @vk = vk_client
    @user = vk_user
  end

  test 'create and find from VK' do
    assert_difference 'Player.count' do
      Player.find_or_create_from_vk(@vk)
    end

    player = Player.last
    assert_equal @user.uid, player.vk_id
    assert_equal @vk.token, player.vk_token

    assert_no_difference 'Player.count' do
      vk_player = Player.find_or_create_from_vk(@vk)
      assert_equal player, vk_player
    end
  end

  def vk_client
    users = stub(get: [vk_user])
    friends = stub(get: [])
    stub(users: users, token: 'token', friends: friends)
  end

  def vk_user
    stub(first_name: 'Foo', last_name: 'Bar', photo_medium: nil, photo_big: nil, uid: 2)
  end
end
