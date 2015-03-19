class ProductsController < ApplicationController
  before_filter :find_factory
  before_filter :find_product,
                :only => [:update, :destroy]

  def index
    find_company
    @products = @factory.products
  end

  def show
    @product = @factory.products.find(params[:id])
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
