class StoreController < ApplicationController
  def index
    @products = Product.order(:productName)
    @search = params["search"]
    if @search.present?
      @product = @search["product"]
#      @products = Product.where("productName LIKE ?", "%#{@name}%")
      @products = Product.where("productName LIKE ?", "%#{@product}%").paginate(page: params[:page], per_page: 10)
    else
      @products = Product.paginate(page: params[:page], per_page: 10)  
    end
#    @products = Product.paginate(page: params[:page], per_page: 10) 
  end
  
end
