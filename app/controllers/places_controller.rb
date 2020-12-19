class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  layout 'jumbotron'

  # GET /places
  # GET /places.json
  def index
    @places = Place.order(:postcode).page(params[:page])
  end

  # GET /places/1
  # GET /places/1.json
  def show
  end

  # GET /places/1/edit
  def edit
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.find_or_initialize_by(new_place_params.slice(:google_maps_id)) do |place|
      place.assign_attributes(new_place_params)
    end

    respond_to do |format|
      if @place.save
        format.html { redirect_to action: :show, id: @place.to_param }
        format.json { render :show, status: :created, location: @place }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /places/1
  # PATCH/PUT /places/1.json
  def update
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to helpers.places_url }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.json
  def destroy
    @place.destroy
    respond_to do |format|
      format.html { redirect_to helpers.places_url }
      format.json { head :no_content }
    end
  end

private
  def set_place
    @place = Place.find(params[:id])
  end

  def new_place_params
    params.require(:place).permit(:name, :latitude, :longitude, :google_maps_id)
  end
  def place_params
    params.require(:place).permit(:name, :address, :hood, :city, :province, :postcode, :latitude, :longitude, :phone, :website)
  end
end
