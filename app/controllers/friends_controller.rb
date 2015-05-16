class FriendsController < ApplicationController
  before_action :set_friend, only: :destroy

  def index
    @friends = current_player.friends
  end

  def destroy
    current_player.friends.destroy(@friend)
    head :no_content
  end

  private

  def set_friend
    @friend = current_player.friends.find(params[:id])
  end
end
