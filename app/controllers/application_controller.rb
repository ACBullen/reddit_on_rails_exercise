class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def log_in(user)
    session[:session_token] = user.session_token
  end

  def must_be_logged_in
    redirect_to new_session_url unless current_user  
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
