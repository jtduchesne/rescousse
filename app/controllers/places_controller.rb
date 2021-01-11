class PlacesController < ApplicationController
  before_action :require_login, only: [:index]

  # GET /places
  # GET /places.json
  def index
    if logged_in_as_admin?
      @places = Place.all
    else
      @places = current_user.favorites
    end
    @places = @places.order(:postcode).page(params[:page])
    
    render :index, layout: 'container'
  end

  # GET /places/1
  # GET /places/1.json
  def show
    @place = Place.includes(:menu).find(params[:id])
    @items = @place.menu.items.order(price: :desc)
    
    render :show, layout: 'container'
  end

  # POST /places
  # POST /places.json
  def create
    @place = Place.find_or_create_by!(new_place_params.slice(:uid)) do |place|
      place.assign_attributes(new_place_params)
    end

    respond_to do |format|
      format.html { redirect_to action: :show, id: @place.to_param }
      format.json { render :show, status: :created, location: @place }
    end
  rescue => e
    logger.warn "PlacesController::create{" + new_place_params.inspect + "} failed.\n" +
                "  " + e.inspect
    redirect_to root_url, alert: t('places.create.failure')
  end

  #--------------------------------------------------------------------------------#
  with_options only: [:edit, :update, :destroy] do
    before_action :require_admin
    before_action :set_place
    
    layout 'jumbotron'
  end

  # GET /places/1/edit
  def edit
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
    params.require(:place).permit(:name, :latitude, :longitude, :uid)
  end
  def place_params
    params.require(:place).permit(:name, :address, :hood, :city, :province, :postcode, :latitude, :longitude, :phone, :website)
  end
end
