class Admin::FactsController < Admin::AdminController
  before_action :set_fact, except: [:index, :new, :create]
  def index
    @facts = Fact.all
  end

  def show
  end

  def new
    @fact = Fact.new
  end

  def create
    @fact = Fact.new(fact_params)

    if @fact.save
      redirect_to admin_facts_path, notice: 'Fact was created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @fact.update(fact_params)
      redirect_to admin_facts_path, notice: 'Fact was updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @fact.destroy
    redirect_to admin_facts_path, notice: 'Fact was destroyed successfully.'
  end

  private

  def fact_params
    params.require(:fact).permit(:content)
  end

  def set_fact
    @fact = Fact.find(params[:id])
  end
end
