class ReportsController < ApplicationController
  def create
    @report = Report.new(report_params)

    if @report.save
      render :show, status: :created
    else
      render json: @report.errors, status: 422
    end
  end

  private

  def report_params
    params.permit(:message, :player_id, :question_id)
  end
end
