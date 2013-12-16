class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # Rails 4 comes with a new strong_parameter feaure
  # that makes CanCan to boom!
  # the workarraund below is just an small fix till CanCan
  # gets fixed
  # more info at:
  # http://stackoverflow.com/a/18766552/1738416
  # and
  # https://github.com/ryanb/cancan/issues/835#issuecomment-18663815

  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

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