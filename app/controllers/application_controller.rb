class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_filter ->{UserSession.storage = session} #Set user session storage


  def current_user(user = nil)
    if current_session = UserSession.current
        if @current_user && @current_user.id == current_session.user_id
          @current_user
        else
          @current_user = User.find_by_id(current_session.user_id)
        end  
    end
  end

  def current_user!(user)
    if user
      UserSession.current_user = user
    else
      @current_user = nil
      UserSession.destroy_current
    end
    current_user
  end
end
