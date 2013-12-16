class BooksController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :only => [:index, :search]

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      flash[:notice] = "Libro Guardado"
      redirect_to books_path
    else
      render action: :new
    end
  end

  def show
    @book = Book.find(book_id)
  end

  def destroy
    @book = Book.find(book_id)
    @book.destroy
    redirect_to books_path
  end

  private
  # this is a workarraound to make CanCan work with Rails4
  # please refer to application_controller to get more info
  # about it
  def books_params
    params.require(:book).permit(:title, :author_id, :editorial_id, :published_date, :format)
  end

  def book_id
    params.require(:book).permit(:id)
  end
end
