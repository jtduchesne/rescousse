class UserController < ApplicationController
  before_action :get_referer_from_session, only: [:destroy, :create, :failure]

  layout 'jumbotron'

  # GET /login
  def new
  end

  # GET /logout
  def destroy
    self.current_user = nil
    redirect_to root_url, notice: t('user.logged_out')
  end

  # GET /auth/:provider/callback
  def create
    self.current_user = User.from_omniauth(auth_params)
    redirect_to @referer || root_url, notice: t('user.logged_in', name: current_user.first_name)
  end

  # GET /auth/failure
  def failure
    if params[:message].present? && params[:message] == "no_authorization_code"
      message = t('user.rejected', by: params[:strategy].humanize)
    else
      message = t('user.failure', msg: params[:message].humanize)
    end
    redirect_to root_url, alert: message
  end

  #--------------------------------------------------------------------------------#
  with_options only: [:show, :edit, :update] do
    before_action :require_login
    before_action :set_user
  end

  # GET /user
  def show
  end

  # GET /user/edit
  def edit
  end

  # PATCH/PUT /user
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to helpers.current_user_url }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def get_referer_from_session
    @referer = session.delete(:referer).presence
  end
  
  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def auth_params
    request.env.fetch('omniauth.auth').to_hash
  end
end
