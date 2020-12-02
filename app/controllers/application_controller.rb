class ApplicationController < ActionController::Base
  before_action :set_locale
  
  def default_url_options
    { locale: I18n.locale.to_s.presence }
  end
  
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
