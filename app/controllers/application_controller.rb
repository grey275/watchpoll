class ApplicationController < ActionController::API
  private
  def current_user_session
    UserSession.find session[:user_session_id]
  end
end
