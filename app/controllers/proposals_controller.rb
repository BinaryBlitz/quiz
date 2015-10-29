class ProposalsController < ApplicationController
  def create
    @proposal = current_player.proposals.build(proposal_params)

    if @proposal.save
      render :show, status: :created
    else
      render json: @proposal.errors, status: 422
    end
  end

  private

  def proposal_params
    params.require(:proposal).permit(:content, :topic_id, answers: [])
  end
end
