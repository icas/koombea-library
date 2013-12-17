class EditorialsController < ApplicationController

  load_and_authorize_resource
  skip_load_resource :only => [:create, :update]

  def index
    @editorials = Editorial.all
  end

  def new
  end

  def create
    @editorial = Editorial.new(editorials_params)
    if @editorial.save
      flash[:notice] = "Editorial Guardada"
      redirect_to editorials_path
    else
      render action: :new
    end
  end

  def show
    @editorial = Editorial.find params[:id]
  end

  def edit
    @editorial = Editorial.find params[:id]
  end

  def update
    @editorial = Editorial.find params[:id]
    if @editorial.update(editorials_params)
      flash[:notice] = "Cambios Guardados"
      redirect_to editorials_path
    else
      render 'edit'
    end
  end

  def destroy
    @editorial = Editorial.find params[:id]
    @editorial.destroy
    flash[:notice] = "Editorial Eliminada"
    redirect_to editorials_path
  end

private
  # this is a workarraound to make CanCan work with Rails4
  # please refer to application_controller to get more info
  # about it
  # Note: the name must match the controller_name in plural
  # like posts_params. Note the 's'
  def editorials_params
    params.require(:editorial).permit(:name)
  end
end
