class FriendshipsController < ApplicationController
  # GET /friendships
  def index
    @friends = current_player.friends
  end

  # POST /friendships
  def create
    @friendship = current_player.friendships.build(friend: Player.find(params[:friend_id]))
    if @friendship.save
      logger.debug 'Friend added.'
      @friendship.friend.push_friend_request_from(current_player)
      head :created
    else
      head :unprocessable_entity
    end
  end

  # DELETE /friendships
  def unfriend
    @friendship = current_player.friendships.find_by(friend_id: params[:friend_id])
    @friendship.destroy
    head :no_content
  end

  # GET /friendships/requests
  def requests
    @friendships = Friendship.where(friend: current_player)
  end

  # PATCH /friendships/mark_requests_as_viewed
  def mark_requests_as_viewed
    friendships = Friendship.where(friend: current_player).where(viewed: false)
    friendships.each { |friendship| friendship.update(viewed: true) }
    head :no_content
  end
end
