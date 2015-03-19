class FactoriesController < ApplicationController
  before_filter :find_company
  before_filter :find_factory,
                :only => [:update, :destroy]

  def index
    @factories = @company.factories
  end

  def show
    @factory = @company.factories.find(params[:id])
  end

  def new
    @factory = @company.factories.build
  end

  def create
    @factory = @company.factories.build(params[:factory])
    if @factory.save
      redirect_to company_factory_url(@company, @factory)
    else
      render :action => "new"
    end
  end

  def edit
    @factory = @company.factories.find(params[:id])
  end

  def update
    if @factory.update_attributes(params[:factory])
      redirect_to company_factory_url(@company, @factory)
    else
      render :action => "edit"
    end
  end

  def destroy
    @factory.destroy

    respond_to do |format|
      format.html { redirect_to company_factory_url(@company) }
      format.xml  { head :ok }
    end
  end

  private
    def find_factory
      @factory = Factory.find(params[:id])
    end

  private
    def find_company
      @company = Company.find(params[:company_id])
    end
end
