class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  helper_method :current_user

  def user_session
    @user_session ||= UserSession.new(session)
  end

  def current_user
    email = user_session.user_email
    @current_user ||= User.find_by_email(email) if email
  end
end