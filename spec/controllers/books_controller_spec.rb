require 'spec_helper'

describe BooksController do
  context "#index" do
    it "lists all the books" do
      books = Fabricate.times(3, :book)
      get :index
      expect(assigns(:books)).to match_array(books)
    end
  end
end
