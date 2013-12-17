require 'spec_helper'

describe AuthorsController, "all roles" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #index" do
    let(:authors) do
      Fabricate.times(2, :author)
    end

    it "lists all the authors" do
      @ability.can :read, Author
      get :index
      expect(assigns(:authors)).to match_array(authors)
    end
  end

  context "GET #show" do
    let(:author) { Fabricate(:author) }
    it "shows the selected author" do
      @ability.can :read, Author
      get :show, id: author
      assigns(:author).should == author
    end
  end
end

describe AuthorsController, "user role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #new" do
    it "redirects to home" do
      @ability.can :read, Author
      get :new
      expect(response).to redirect_to root_url
    end
  end

  context "POST #create" do
    it "redirects to home" do
      @ability.cannot :create, Author
      post :create, author: {}
      expect(response).to redirect_to root_url
    end
  end

  context "GET #edit" do
    it "redirects to home" do
      author = Fabricate(:author)
      @ability.cannot :update, Author
      get :edit, id: author.id
      expect(response).to redirect_to root_url
    end
  end

  context "PUT #update" do
    it "redirects to home" do
      author = Fabricate(:author)
      @ability.cannot :update, Author
      put :update, id: author.id
      expect(response).to redirect_to root_url
    end
  end

  context "DELETE #destroy" do
    it "redirects to home" do
      author = Fabricate(:author)
      @ability.cannot :delete, Author
      delete :destroy, id: author.id
      expect(response).to redirect_to root_url
    end
  end
end

describe AuthorsController, "admin and root role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
    @ability.can :create, Author
    @ability.can :destroy, Author
  end

  context "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    let(:attributes) { Fabricate.attributes_for(:author) }
    it "creates a new author" do
      expect{
        post :create, author: attributes
      }.to change(Author, :count).by(1)
    end

    it "redirects to authors_path" do
      post :create, author: attributes
      expect(response).to redirect_to authors_path
    end
  end

  context "GET #edit" do
    it "renders the edit template" do
      author = Fabricate(:author)
      @ability.can :update, Author
      get :edit, id: author.id
      expect(response).to render_template :edit
    end
  end

  context "PUT #update" do
    it "updates an author" do
      author = Fabricate(:author)
      @ability.can :update, Author
      put :update, id: author, author: Fabricate.attributes_for(:author, name: "the new name")
      assigns(:author).name.should eq("the new name")
    end
  end

  context "DELETE #destroy" do
    before do
      @author = Fabricate(:author)
    end
    it "creates a new author" do
      expect{
        delete :destroy, id: @author
      }.to change(Author, :count).by(-1)
    end

    it "redirects to books_path" do
      delete :destroy, id: @author
      expect(response).to redirect_to authors_path
    end
  end
end