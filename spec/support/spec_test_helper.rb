module SpecTestHelper
  def login(user)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end
end