require 'spec_helper'

describe UserSession do
  let(:storage) do
    {}
  end

  before do
    UserSession.storage = storage
  end

  describe ".current=" do
    let(:user){FactoryGirl.build_stubbed(:user)}
    
    it "set current id from user" do
      UserSession.current_user = user
      expect(UserSession.current.user_id).to be_eql(user.id)
    end
  end

  describe ".current" do
    before{storage[:user_id] = "someid"}

    context "when user id is set in storage" do
      it "returns user session with user id stored" do
        expect(UserSession.current.user_id).to be_eql(storage[:user_id])
      end
    end

    context "when  user id is not set in storage" do
      before{storage[:user_id] = nil}
      it "return nil" do
        expect(UserSession.current).to be(nil)
      end
    end
  end

  describe ".destroy_current" do
    before{storage[:user_id] = "someid"}
    it "removes user id from storage" do
      UserSession.destroy_current
      expect(storage[:user_id]).to be(nil)

    end
  end
end