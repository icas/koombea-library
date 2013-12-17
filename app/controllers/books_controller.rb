class BooksController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create, :update]

  def index
    @books = Book.search(params[:search])
  end

  def new
  end

  def create
    @book = Book.new(books_params)
    if @book.save
      flash[:notice] = "Libro Guardado"
      redirect_to books_path
    else
      flash[:error] = "No pudimos guardar el libro"
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
      flash[:notice] = "Cambios Guardados"
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
  # about it.
  # Note: the name must match the controller_name in plural
  # like posts_params. Note the 's'
  def books_params
    params.require(:book).permit(:title, :author_id, :editorial_id, :published_date, :format)
  end
end
