require 'spec_helper'

describe UserSession do
  before(:each) do
    @session = UserSession.new({})
  end

  it "sets the email" do
    user = double(email: "email")
    @session.start_session(user)
    @session.user_email.should eq("email")
  end
end