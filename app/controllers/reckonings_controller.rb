class ReckoningsController < ApplicationController
  # GET /reckonings
  # GET /reckonings.json
  def index
    @reckonings = Reckoning.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reckonings }
    end
  end

  # GET /reckonings/1
  # GET /reckonings/1.json
  def show
    @reckoning = Reckoning.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reckoning }
    end
  end

  # GET /reckonings/new
  # GET /reckonings/new.json
  def new
    @reckoning = Reckoning.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reckoning }
    end
  end

  # GET /reckonings/1/edit
  def edit
    @reckoning = Reckoning.find(params[:id])
  end

  # POST /reckonings
  # POST /reckonings.json
  def create
    @reckoning = Reckoning.new(params[:reckoning])

    respond_to do |format|
      if @reckoning.save
        format.html { redirect_to @reckoning, notice: 'Reckoning was successfully created.' }
        format.json { render json: @reckoning, status: :created, location: @reckoning }
      else
        format.html { render action: "new" }
        format.json { render json: @reckoning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reckonings/1
  # PUT /reckonings/1.json
  def update
    @reckoning = Reckoning.find(params[:id])

    respond_to do |format|
      if @reckoning.update_attributes(params[:reckoning])
        format.html { redirect_to @reckoning, notice: 'Reckoning was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @reckoning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reckonings/1
  # DELETE /reckonings/1.json
  def destroy
    @reckoning = Reckoning.find(params[:id])
    @reckoning.destroy

    respond_to do |format|
      format.html { redirect_to reckonings_url }
      format.json { head :no_content }
    end
  end
end
