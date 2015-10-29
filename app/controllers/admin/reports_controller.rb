class Admin::ReportsController < Admin::AdminController
  before_action :set_report, only: [:show, :destroy]

  def index
  end

  def players
    @reports = Report.players.page(params[:page])
  end

  def questions
    @reports = Report.questions.page(params[:page])
  end

  def feedback
    @reports = Report.feedback.page(params[:page])
  end

  def destroy
    @report.destroy
    redirect_to :back, notice: 'Жалоба успешно удалена.'
  end

  private

  def set_report
    @report = Report.find(params[:id])
  end
end
