class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception

  protect_from_forgery with: :null_session

  helper_method :current_user, :logged_in?, :is_admin?

  def current_user
    @current_user ||= Shopper.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !current_user.nil?
  end

  def is_admin?
    !current_user.nil? && current_user.admin?
  end

end
