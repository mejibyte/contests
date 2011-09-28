class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_session_url, :alert => exception.message
  end
  
  helper_method :current_user
  
  def current_user
    session[:admin]
  end
end
