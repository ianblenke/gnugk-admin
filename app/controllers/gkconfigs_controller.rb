class GkconfigsController < ApplicationController
  # GET /gkconfigs
  # GET /gkconfigs.json
  def index
    @gkconfigs = Gkconfig.all
    @gksections = Gksection.ordered_by_name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gkconfigs }
    end
  end

  # GET /gkconfigs/1
  # GET /gkconfigs/1.json
  def show
    @gkconfig = Gkconfig.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gkconfig }
    end
  end

  # GET /gkconfigs/new
  # GET /gkconfigs/new.json
  def new
    @gkconfig = Gkconfig.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gkconfig }
    end
  end

  # GET /gkconfigs/1/edit
  def edit
    @gkconfig = Gkconfig.find(params[:id])
  end

  # POST /gkconfigs
  # POST /gkconfigs.json
  def create
    @gkconfig = Gkconfig.new(params[:gkconfig])

    respond_to do |format|
      if @gkconfig.save
        format.html { redirect_to @gkconfig, notice: 'Gkconfig was successfully created.' }
        format.json { render json: @gkconfig, status: :created, location: @gkconfig }
      else
        format.html { render action: "new" }
        format.json { render json: @gkconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gkconfigs/1
  # PUT /gkconfigs/1.json
  def update
    @gkconfig = Gkconfig.find(params[:id])

    respond_to do |format|
      if @gkconfig.update_attributes(params[:gkconfig])
        format.html { redirect_to @gkconfig, notice: 'Gkconfig was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gkconfig.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gkconfigs/1
  # DELETE /gkconfigs/1.json
  def destroy
    @gkconfig = Gkconfig.find(params[:id])
    @gkconfig.destroy

    respond_to do |format|
      format.html { redirect_to gkconfigs_url }
      format.json { head :no_content }
    end
  end
end
