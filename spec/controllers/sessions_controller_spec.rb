# sessions_controller_spec.rb
require 'spec_helper'

describe SessionsController do

  before do
    request.env['omniauth.auth'] = OmniAuth::AuthHash.new({
      'provider' => 'google_apps',
      'uid' => '123545',
      'info' => {
        'email' => 'anewuser@koombea.com',
        'first_name' => 'Ricardo',
        'last_name' => 'Berdejo'
      }
    });

  end

  describe "#create" do

    it "should successfully create a user" do
      expect {
        post :create, provider: :google_apps
      }.to change{ User.count }.by(1)
    end

    it "should successfully create a session" do
      post :create, provider: :google_apps
      UserSession.current.should_not be_nil
    end

    it "should redirect the user to the root url" do
      post :create, provider: :google_apps
      response.should redirect_to root_url
    end

  end

  describe "#destroy" do
    before do
      post :create, provider: :google_apps
    end

    it "should clear the session" do
      get :destroy
      assigns(:current_user).should be_nil
    end

    it "should redirect to the home page" do
      get :destroy
      response.should redirect_to root_url
    end
  end

end