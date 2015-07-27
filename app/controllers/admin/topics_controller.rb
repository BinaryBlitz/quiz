class Admin::TopicsController < Admin::AdminController
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.includes(:category).order('categories.name ASC').page(params[:page])
  end

  def show
    @questions = Question.where(topic: @topic).page(params[:page])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)

    if @topic.save
      redirect_to [:admin, @topic], notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @topic.update(topic_params)
      redirect_to [:admin, @topic], notice: 'Topic was successfully updated.'
    else
      render :new
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_topics_path, notice: 'Topic was successfully destroyed.'
  end

  private

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def topic_params
    params.require(:topic).permit(
      :name, :visible, :expires_at, :featured,
      :category_id, purchase_type_attributes: [:id, :identifier])
  end
end
