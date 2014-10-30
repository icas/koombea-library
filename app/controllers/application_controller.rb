class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_filter ->{UserSession.storage = session} #Set user session storage


  def current_user
    @current_user ||= if current_session = UserSession.current
                          User.find_by_id(current_session.user_id)
                      end
  end

  def current_user2=(user)
    UserSession.current_user = user
  end
end
