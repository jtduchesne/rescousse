class ApplicationController < ActionController::Base
  before_action :set_locale
  
  def default_url_options
    { locale: I18n.locale.to_s.presence }
  end
  
protected
  def require_login
    unless logged_in?
      session[:referer] = request.url
      redirect_to helpers.login_url
    end
  end
  def require_admin
    redirect_to helpers.root_url unless logged_in_as_admin?
  end
  
  def current_position
    session[:position] ||= Position.find_or_create_by(
      ip_address: request.remote_ip
    ).increment(:count).slice(:lat, :lng)
  end
  helper_method :current_position
  
  def current_user
    if @current_user.nil?
      @current_user = session[:user_id] ? User.find(session[:user_id]) : false
    end
    @current_user
  end
  def current_user=(user)
    reset_session
    if user
      @current_user = user
      session[:user_id] = user.id
    else
      @current_user = false
    end
  end
  helper_method :current_user
  
  def logged_in?
    !!current_user
  end
  def logged_out?
    !current_user
  end
  def logged_in_as_admin?
    logged_in? && current_user.admin?
  end
  helper_method :logged_in?, :logged_out?, :logged_in_as_admin?
  
private
  def set_locale
    if locale = params[:locale].presence
      I18n.locale = locale
      
      if locale == preferred_language
        params[:locale] = nil
      end
    else
      I18n.locale = preferred_language || I18n.default_locale
    end
  end
  
  def preferred_language
    request.headers['HTTP_ACCEPT_LANGUAGE'] &&
    request.headers['HTTP_ACCEPT_LANGUAGE'].scan(/fr|en/i).first
  end
end
