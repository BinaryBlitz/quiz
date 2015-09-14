class Admin::ProposalsController < Admin::AdminController
  before_action :set_proposal, except: [:index]

  def index
    @proposals = Proposal.all.page(params[:page]).per(10)
  end

  def approve
    question = @proposal.approve
    redirect_to edit_admin_question_path(question), notice: 'Вопрос добавлен.'
  end

  def destroy
    @proposal.destroy
    redirect_to admin_proposals_path, notice: 'Предложение отклонено.'
  end

  private

  def set_proposal
    @proposal = Proposal.find(params[:id])
  end
end
