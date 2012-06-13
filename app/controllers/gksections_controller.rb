class GksectionsController < ApplicationController
  # GET /gksections
  # GET /gksections.json
  def index
    @gksections = Gksection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @gksections }
    end
  end

  # GET /gksections/1
  # GET /gksections/1.json
  def show
    @gksection = Gksection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @gksection }
    end
  end

  # GET /gksections/new
  # GET /gksections/new.json
  def new
    @gksection = Gksection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @gksection }
    end
  end

  # GET /gksections/1/edit
  def edit
    @gksection = Gksection.find(params[:id])
  end

  # POST /gksections
  # POST /gksections.json
  def create
    @gksection = Gksection.new(params[:gksection])

    respond_to do |format|
      if @gksection.save
        format.html { redirect_to @gksection, notice: 'Gksection was successfully created.' }
        format.json { render json: @gksection, status: :created, location: @gksection }
      else
        format.html { render action: "new" }
        format.json { render json: @gksection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /gksections/1
  # PUT /gksections/1.json
  def update
    @gksection = Gksection.find(params[:id])

    respond_to do |format|
      if @gksection.update_attributes(params[:gksection])
        format.html { redirect_to @gksection, notice: 'Gksection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @gksection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gksections/1
  # DELETE /gksections/1.json
  def destroy
    @gksection = Gksection.find(params[:id])
    @gksection.destroy

    respond_to do |format|
      format.html { redirect_to gksections_url }
      format.json { head :no_content }
    end
  end
end
