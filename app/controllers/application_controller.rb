class ApplicationController < ActionController::Base
  check_authorization
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
    session[:return_to] = request.path
    redirect_to new_session_url, :alert => exception.message
  end
  
  helper_method :current_user, :logged_in?
  
  def current_user
    session[:admin]
  end
  
  def logged_in?
    current_user.present?
  end
  
end
