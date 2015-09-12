class ParticipationsController < ApplicationController
  before_action :set_participation, except: [:create]

  def create
    @participation = current_player.participations.build(participation_params)
    authorize @participation

    if @participation.save
      head :created
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  def update
    if @participation.update(participation_params)
      head :ok
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @participation.destroy
    authorize @participation
    head :no_content
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end

  def participation_params
    params.permit(:ready, :topic_id, :room_id)
  end
end
