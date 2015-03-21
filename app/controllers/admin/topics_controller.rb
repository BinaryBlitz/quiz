class Admin::TopicsController < Admin::AdminController
  before_action :find_topic, only: [:show, :edit, :update, :destroy]

  def index
    @topics = Topic.where(visible: true)
  end

  def show
    @questions = Question.where(topic: @topic)
  end

  def new
    @topic = Topic.new
    @topic.build_purchase_type
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
      :name, :visible, :expires_at, :price,
      :played_count, :category_id, purchase_type_attributes: [:id, :identifier])
  end
end
