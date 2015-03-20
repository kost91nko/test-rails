class ProductsController < ApplicationController
  before_filter :find_factory,
                :except => [:data, :dbaction, :view, :show]
  before_filter :find_product,
                :only => [:update, :destroy]

  def index
    find_company
    @products = @factory.products
  end

  def show
    @product = Product.find(params[:id])
    @factory = Factory.find(@product.factory_id)
  end

  def new
    @product = @factory.products.build
  end

  def create
    @product = @factory.products.build(params[:product])
    if @product.save
      redirect_to factory_product_url(@factory, @product)
    else
      render :action => "new"
    end
  end

  def edit
    @product = @factory.products.find(params[:id])
  end

  def update
    if @product.update_attributes(params[:product])
      redirect_to factory_product_url(@factory, @product)
    else
      render :action => "edit"
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to factory_product_url(@factory) }
      format.xml  { head :ok }
    end
  end

  # DHTMLX
  def data
    @products = Product.all
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
        product = Product.new
        product.name = name
        product.description = description
        product.save!

        @tid = product.id
      when "deleted"
        product=Product.find(@id)
        product.destroy

        @tid = @id
      when "updated"
        product=Product.find(@id)
        product.name = name
        product.description = description
        product.save!

        @tid = @id
    end
  end

  private
    def find_product
      @product = Product.find(params[:id])
    end

  private
    def find_factory
      @factory = Factory.find(params[:factory_id])
    end

  private
    def find_company
      @factory ||= Factory.find(params[:factory_id])
      @company = Company.find(@factory.company_id)
    end
end
