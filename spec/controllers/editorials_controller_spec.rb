require 'spec_helper'

describe EditorialsController, "all roles" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #index" do
    let(:editorials) do
      Fabricate.times(2, :editorial)
    end

    it "lists all the editorials" do
      @ability.can :read, Editorial
      get :index
      expect(assigns(:editorials)).to match_array(editorials)
    end
  end

  context "GET #show" do
    let(:editorial) { Fabricate(:editorial) }
    it "shows the selected editorial" do
      @ability.can :read, Editorial
      get :show, id: editorial
      assigns(:editorial).should == editorial
    end
  end
end

describe EditorialsController, "user role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #new" do
    it "redirects to home" do
      @ability.can :read, Editorial
      get :new
      expect(response).to redirect_to root_url
    end
  end

  context "POST #create" do
    it "redirects to home" do
      @ability.cannot :create, Editorial
      post :create, editorial: {}
      expect(response).to redirect_to root_url
    end
  end

  context "GET #edit" do
    it "redirects to home" do
      editorial = Fabricate(:editorial)
      @ability.cannot :update, Editorial
      get :edit, id: editorial.id
      expect(response).to redirect_to root_url
    end
  end

  context "PUT #update" do
    it "redirects to home" do
      editorial = Fabricate(:editorial)
      @ability.cannot :update, Editorial
      put :update, id: editorial.id
      expect(response).to redirect_to root_url
    end
  end

  context "DELETE #destroy" do
    it "redirects to home" do
      editorial = Fabricate(:editorial)
      @ability.cannot :delete, Editorial
      delete :destroy, id: editorial.id
      expect(response).to redirect_to root_url
    end
  end
end

describe EditorialsController, "admin and root role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
    @ability.can :create, Editorial
    @ability.can :destroy, Editorial
  end

  context "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    let(:attributes) { Fabricate.attributes_for(:editorial) }
    it "creates a new editorial" do
      expect{
        post :create, editorial: attributes
      }.to change(Editorial, :count).by(1)
    end

    it "redirects to editorials_path" do
      post :create, editorial: attributes
      expect(response).to redirect_to editorials_path
    end
  end

  context "GET #edit" do
    it "renders the edit template" do
      editorial = Fabricate(:editorial)
      @ability.can :update, Editorial
      get :edit, id: editorial.id
      expect(response).to render_template :edit
    end
  end

  context "PUT #update" do
    it "updates an editorial" do
      editorial = Fabricate(:editorial)
      @ability.can :update, Editorial
      put :update, id: editorial, editorial: Fabricate.attributes_for(:editorial, name: "the new name")
      assigns(:editorial).name.should eq("the new name")
    end
  end

  context "DELETE #destroy" do
    before do
      @editorial = Fabricate(:editorial)
    end
    it "creates a new editorial" do
      expect{
        delete :destroy, id: @editorial
      }.to change(Editorial, :count).by(-1)
    end

    it "redirects to books_path" do
      delete :destroy, id: @editorial
      expect(response).to redirect_to editorials_path
    end
  end
end