require 'spec_helper'

describe BooksController, "all roles" do
  before do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    controller.stub(:current_ability) { @ability }
  end

  context "GET #index" do
    let(:books) do
      Fabricate.times(2, :book)
    end

    it "lists all the books" do
      @ability.can :read, Book
      get :index
      expect(assigns(:books)).to match_array(books)
    end

    it "shows a list of books matching the query" do
      @ability.can :read, Book
      get :index, query: "search"
      book = Fabricate(:book, title: "search")
      expect(assigns(:books)).to match_array([book])
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
      expect(response).to redirect_to root_url
    end
  end

  context "POST #create" do
    it "redirects to home" do
      @ability.cannot :create, Book
      post :create, book: {}
      expect(response).to redirect_to root_url
    end
  end

  context "GET #edit" do
    it "redirects to home" do
      book = Fabricate(:book)
      @ability.cannot :update, Book
      get :edit, id: book.id
      expect(response).to redirect_to root_url
    end
  end

  context "PUT #update" do
    it "redirects to home" do
      book = Fabricate(:book)
      @ability.cannot :update, Book
      put :update, id: book.id
      expect(response).to redirect_to root_url
    end
  end

  context "DELETE #destroy" do
    it "redirects to home" do
      book = Fabricate(:book)
      @ability.cannot :delete, Book
      delete :destroy, id: book.id
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

  context "GET #edit" do
    it "renders the edit template" do
      book = Fabricate(:book)
      @ability.can :update, Book
      get :edit, id: book.id
      expect(response).to render_template :edit
    end
  end

  context "PUT #update" do
    it "updates a book" do
      book = Fabricate(:book)
      @ability.can :update, Book
      put :update, id: book, book: Fabricate.attributes_for(:book, title: "the new title")
      assigns(:book).title.should eq("the new title")
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