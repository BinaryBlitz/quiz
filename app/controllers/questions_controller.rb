class QuestionsController < ApplicationController
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

  # POST /questions
  def create
    @question = Question.new(question_params)

    if @question.save
      render json: @question, status: :created, location: @player
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # PATCH /questions/1
  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      head :no_content
    else
      render json: @question.errors, status: :unprocessable_entity
    end
  end

  # DELETE /questions/1
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    head :no_content
  end

  private

  def question_params
    params.require(:question).permit(:text, :correct_answer, answers: [])
  end
end
