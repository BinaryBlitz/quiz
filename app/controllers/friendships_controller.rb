class FriendshipsController < ApplicationController
  def index
    @friends = current_player.friends
    render formats: :json
  end

  def create
    @friendship = current_player.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      # Push
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
end
