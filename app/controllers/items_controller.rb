class ItemsController < ApplicationController

  def new
    @list = List.find params[:list_id]
    @item = @list.items.new
    @imgs = []
  end

  def edit
    @list = List.find params[:list_id]
    @item = Item.find params[:id]
  end

  def create
    @list = List.find params[:list_id]
    @item = @list.items.new item_params
    if params[:item][:picture_url] && params[:item][:picture_url] != ""
      cloudinary_upload =  Cloudinary::Uploader.upload(params[:item][:picture_url])
      @item.remote_picture_url = cloudinary_upload["url"]
    end
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

  def reserve
    item = Item.find params[:id]
    item.reservation = params[:reservation]
    if item.save
      render json: {}
    else
      render status: 400, nothing: true
    end
  end

  def parse
    @list = List.find params[:list_id]
    @item = @list.items.new

    url = params[:url_parse]
    if url
      begin
        page = open(url)
      rescue Exception => e
        flash[:danger] = "Impossible to open that url"
      end
      if page
        doc = Nokogiri::HTML(page)
        if doc.css("title")
          @item.title = doc.css("title").text
        end
        @item.url = url
        @imgs = []
        doc.css("img").each do |image|
          @imgs << image.attr('src')
        end
      end
    end
    render :new
  end

  private

  def item_params
    params.require(:item).permit(:title, :url, :price, :comment, :list_id, :picture, :reservation)
  end

end
