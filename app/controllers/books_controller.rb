class BooksController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create, :update]

  def index
    @books = Book.all
  end

  def new
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
    @book = Book.find params[:id]
  end

  def edit
    @book = Book.find params[:id]
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
      redirect_to books_path
    else
      render 'edit'
    end
  end

  def destroy
    @book = Book.find params[:id]
    @book.destroy
    flash[:notice] = "Libro Eliminado"
    redirect_to books_path
  end

  private
  # this is a workarraound to make CanCan work with Rails4
  # please refer to application_controller to get more info
  # about it
  def books_params
    params.require(:book).permit(:title, :author_id, :editorial_id, :published_date, :format)
  end
end
