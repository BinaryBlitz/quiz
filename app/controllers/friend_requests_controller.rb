class FriendRequestsController < ApplicationController
  before_action :set_friend_request, except: [:index, :create]

  def index
    @incoming = FriendRequest.where(friend: current_player)
    @outgoing = current_player.friend_requests
  end

  def create
    friend = Player.find(params[:friend_id])
    @friend_request = current_player.friend_requests.build(friend: friend)

    if @friend_request.post
      render :show, status: :created, location: @friend_request
    else
      render json: @friend_request.errors, status: :unprocessable_entity
    end
  end

  def update
    @friend_request.accept
    head :no_content
  end

  def destroy
    @friend_request.destroy
    head :no_content
  end

  private

  def set_friend_request
    @friend_request = FriendRequest.find(params[:id])
  end
end
