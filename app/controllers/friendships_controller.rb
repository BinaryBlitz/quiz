class FriendshipsController < ApplicationController
  def index
    @friends = current_player.friends
    render formats: :json
  end

  def create
    @friendship = current_player.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      logger.debug 'Friend added.'
      @friendship.friend.push_friend_request(current_player)
      head :created
    else
      head :unprocessable_entity
    end
  end

  def unfriend
    @friendship = current_player.friendships.find_by(friend_id: params[:friend_id])
    @friendship.destroy
    head :no_content
  end

  def requests
    friendships = Friendship.where(friend: current_player).where(viewed: false)
    @friends = friendships.map(&:player)
    render formats: :json
  end

  def mark_requests_as_viewed
    friendships = Friendship.where(friend: current_player).where(viewed: false)
    friendships.each { |friendship| friendship.update(viewed: true) }
    head :ok
  end
end
