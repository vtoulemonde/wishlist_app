class ListsController < ApplicationController

  def index
    @lists = List.where(user_id: session[:current_user_id])
  end

  def show
    @list = List.find(params[:id])
  end

  def new
  end

  def edit
    @list = List.find(params[:id])
  end

  def create
    @list = List.new list_params
    @list.user_id = session[:current_user_id]
    if @list.save
      redirect_to @list
    else
      render 'new'
    end
  end

  def update
    @list = List.find(params[:id])
    @list.update list_params

    if @list.update list_params
      flash[:success] = "Your list has been updated."
      redirect_to lists_path
    else
      render :edit
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:user_id, :name, :comment)
  end

end
