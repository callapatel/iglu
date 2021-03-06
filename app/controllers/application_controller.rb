class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
before_action :current_user
helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user #enables you to call current_user in the view now

  def require_login
    unless session[:user_id].present?
      redirect_to connect_path,
      notice: "Please sign in"
    else
      true
    end
  end



end
