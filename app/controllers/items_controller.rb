class ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @want_users = @item.want_users
    @have_users = @item.have_users
  end
  
  def new
    @items = []

    @keyword = params[:keyword]
    if @keyword.present? # 
      results = RakutenWebService::Ichiba::Item.search({
        keyword: @keyword,
        imageFlag: 1,
        hits: 20,
      })

      results.each do |result|
        item = Item.find_or_initialize_by(read(result))
        @items << item
      end
    end
  end
end
