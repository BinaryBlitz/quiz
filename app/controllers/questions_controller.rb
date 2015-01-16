class QuestionsController < ApplicationController
  before_action :restrict_access
  # GET /questions
  def index
    @questions = Question.all
    render json: @questions
  end

  # GET /questions/1
  def show
    @question = Question.find(params[:id])
    render json: @question
  end
end
