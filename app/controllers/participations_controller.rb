class ParticipationsController < ApplicationController
  before_action :set_participation, except: []

  def update
    if @participation.update(participation_params)
      head :ok
    else
      render json: @participation.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @participation.destroy
    head :no_content
  end

  private

  def set_participation
    @participation = Participation.find(params[:id])
  end

  def participation_params
    params.require(:participation).permit(:ready, :topic_id)
  end
end
