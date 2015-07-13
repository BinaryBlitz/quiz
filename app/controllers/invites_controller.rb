class InvitesController < ApplicationController
  before_action :set_invite, except: [:index, :create]

  def show
  end

  def create
    @invite = Invite.new(invite_params)

    if @invite.save
      render :show, status: :created, location: @invite
    else
      render json: @invite.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @invite.destroy
    head :no_content
  end

  private

  def set_invite
    @invite = Invite.find(params[:id])
  end

  def invite_params
    params.require(:invite).permit(:room_id, :player_id)
  end
end
