class CompaniesController < ApplicationController
  before_filter :find_company,
                :only => [:show, :edit, :update, :destroy]
  # GET /companies
  # GET /companies.xml
  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @companies }
    end
  end

  # GET /companies/1
  # GET /companies/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.xml
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company }
    end
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.xml
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to(@company, :notice => 'Company was successfully created.') }
        format.xml  { render :xml => @company, :status => :created, :location => @company }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.xml
  def update
    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to(@company, :notice => 'Company was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.xml
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to(companies_url) }
      format.xml  { head :ok }
    end
  end

  # DHTMLX
  def data
    @companies = Company.all
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
        company = Company.new
        company.name = name
        company.description = description
        company.save!

        @tid = company.id
      when "deleted"
        company=Company.find(@id)
        company.destroy

        @tid = @id
      when "updated"
        company=Company.find(@id)
        company.name = name
        company.description = description
        company.save!

        @tid = @id
    end
  end

  private
    def find_company
      @company = Company.find(params[:id])
    end
end
