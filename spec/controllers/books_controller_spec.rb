require 'spec_helper'

describe BooksController, "all roles" do
  context "GET #index" do
    it "lists all the books" do
      books = Fabricate.times(3, :book)
      get :index
      expect(assigns(:books)).to match_array(books)
    end
  end

  context "GET #show" do
    let(:book) { Fabricate(:book) }
    it "shows the selected book" do
      get :show, id: book
      assigns(:book).should == book
    end
  end
end

describe BooksController, "user role" do

  user = Fabricate(:user) do
    role { Role.find_by_account_type("user") }
  end

  login(user)

  context "GET #new" do
    it "redirects to home" do
      get :new
      expect(response).to redirect_to root_url
    end
  end

  context "POST #create" do
    it "redirects to home" do
      post :create, book: {}
      expect(response).to redirect_to root_url
    end
  end
end

describe BooksController, "admin and root role" do
  user = Fabricate(:user) do
    role { Role.find_by_account_type("admin") }
  end

  login(user)

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
    let(:book) { Fabricate(:book) }
    it "creates a new book" do
      expect{
        delete :destroy, id: book
      }.to change(Book, :count).by(-1)
    end

    it "redirects to books_path" do
      delete :destroy, id: book
      expect(response).to redirect_to books_path
    end
  end
end