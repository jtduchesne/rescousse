class UserController < ApplicationController
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
    redirect_to root_url, notice: t('user.logged_in', name: current_user.first_name)
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

  def show
  end

  def edit
  end

  def update
  end

private
  def auth_params
    request.env.fetch('omniauth.auth').to_hash
  end
end
