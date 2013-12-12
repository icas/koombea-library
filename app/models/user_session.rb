class UserSession
  def initialize(session)
    @session = session
    @session[:user_email] ||= ""
  end

  def start_session(user)
    @session[:user_email] = user.email
  end

  def user_email
    @session[:user_email]
  end

  def destroy
    @session[:user_email] = nil
  end
end