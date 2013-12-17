class AuthorsController < ApplicationController
  load_and_authorize_resource
  skip_load_resource :only => [:create, :update]

  def index
    @authors = Author.all
  end

  def new
  end

  def create
    @author = Author.new(authors_params)
    if @author.save
      flash[:notice] = "Author Guardado"
      redirect_to authors_path
    else
      flash[:error] = "No pudimos guardar el Author"
      render action: :new
    end
  end

  def show
    @author = Author.find params[:id]
  end

  def edit
    @author = Author.find params[:id]
  end

  def update
    @author = Author.find params[:id]
    if @author.update(authors_params)
      flash[:notice] = "Cambios Guardados"
      redirect_to authors_path
    else
      flash[:error] = "No pudimos guardar los cambios"
      render 'edit'
    end
  end

  def destroy
    @author = Author.find params[:id]
    @author.destroy
    flash[:notice] = "Author Eliminado"
    redirect_to authors_path
  end

private
  # this is a workarraound to make CanCan work with Rails4
  # please refer to application_controller to get more info
  # about it
  # Note: the name must match the controller_name in plural
  # like posts_params. Note the 's'
  def authors_params
    params.require(:author).permit(:name)
  end
end