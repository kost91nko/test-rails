class FactoriesController < ApplicationController
  before_filter :find_company,
                :except => [:data, :dbaction, :view]
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

  # DHTMLX
  def data
    @factories = Factory.all
  end

  def dbaction
    #called for all db actions
    ids = params["ids"]
    name        = params[ids + "_c0"]
    description = params[ids + "_c1"]

    logger.debug "Params: name - #{name} description - #{description}"

    @mode = params[ids + "_!nativeeditor_status"]
    logger.debug "Mode: #{@mode}"

    @id = params[ids + "_gr_id"]
    logger.debug "Id: #{@id}"

    case @mode
      when "inserted"
        factory = Factory.new
        factory.name = name
        factory.description = description
        factory.save!

        @tid = factory.id
      when "deleted"
        factory=Factory.find(@id)
        factory.destroy

        @tid = @id
      when "updated"
        factory=Factory.find(@id)
        factory.name = name
        factory.description = description
        factory.save!

        @tid = @id
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
