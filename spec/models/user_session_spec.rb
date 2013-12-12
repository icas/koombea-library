require 'spec_helper'

describe UserSession do
  before(:each) do
    @session = UserSession.new({})
  end

  it "sets the email" do
    @session.current_user("email")
    @session.user_email.should eq("email")
  end
end