require 'spec_helper'

describe BooksController, "all roles" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #index" do
    it "lists all the books" do
      @ability.can :read, Book
      books = Fabricate.times(3, :book)
      get :index
      expect(assigns(:books)).to match_array(books)
    end
  end

  context "GET #show" do
    let(:book) { Fabricate(:book) }
    it "shows the selected book" do
      @ability.can :read, Book
      get :show, id: book
      assigns(:book).should == book
    end
  end
end

describe BooksController, "user role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #new" do
    it "redirects to home" do
      @ability.can :read, Book
      get :new
      expect(response).not_to render_template :new
    end
  end

  context "POST #create" do
    it "redirects to home" do
      @ability.cannot :read, Book
      post :create, book: {}
      expect(response).to redirect_to root_url
    end
  end
end

describe BooksController, "admin and root role" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
    @ability.can :create, Book
    @ability.can :destroy, Book
  end

  context "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  context "POST #create" do
    let(:attributes) { Fabricate.attributes_for(:book) }
    it "creates a new book" do
      expect{
        post :create, book: attributes
      }.to change(Book, :count).by(1)
    end

    it "redirects to books_path" do
      post :create, book: attributes
      expect(response).to redirect_to books_path
    end
  end

  context "DELETE #destroy" do
    before do
      @book = Fabricate(:book)
    end
    it "creates a new book" do
      expect{
        delete :destroy, id: @book
      }.to change(Book, :count).by(-1)
    end

    it "redirects to books_path" do
      delete :destroy, id: @book
      expect(response).to redirect_to books_path
    end
  end
end