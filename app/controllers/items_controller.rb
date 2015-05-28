class ItemsController < ApplicationController

  def new
    @list = List.find params[:list_id]
    @item = @list.items.new
  end

  def edit
    @list = List.find params[:list_id]
    @item = Item.find params[:id]
  end

  def create
    @list = List.find params[:list_id]
    @item = @list.items.new item_params
    if @item.save
      redirect_to @list
    else
      render :new
    end
  end

  def update
    @list = List.find params[:list_id]
    @item = Item.find params[:id]
    if @item.update item_params
      redirect_to @list
    else
      render :edit
    end
  end

  def destroy
    @list = List.find params[:list_id]
    @item = Item.find params[:id]
    @item.destroy
    redirect_to @list
  end

  private

  def item_params
    params.require(:item).permit(:title, :url, :price, :comment, :list_id, :picture)
  end

end
