class SessionsController < ApplicationController
  # debido a que la autenticacion es via google
  # podemos hacer dos cosas:
  # 1. eliminar en application_controller.rb
  # protect_from_forgery with: :exception
  # 2. no verificar el token en los controladores
  skip_before_filter :verify_authenticity_token

  def create
    auth = request.env["omniauth.auth"]
    email = auth['info']['email']

    user = User.find_by_email(email) || User.create_with_omniauth(auth) #Refactor
    current_user2 = user
    redirect_to root_url
  end

  def destroy
    UserSession.destroy_current
    redirect_to root_url
  end
end