class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
    @search = params["search"]
    @filter = params[:categories]
    @categories = Product.distinct.pluck(:productLine)

    if @search.present? || @filter.present?
      if @search.present? && @filter.present?   
        # Search and filter 
        @name = @search["product"]
        session[:categories] = @filter
        @products = Product.where("productLine in (?)", @filter).where("productName LIKE ? or productCode LIKE ?", "%#{@name}%", "%#{@name}%").order('productName').paginate(page: params[:page])      
      elsif @search.present?
        # Search only        
        @name = @search["product"]
        session[:categories] = @filter
        @products = Product.where("productName LIKE ? or productCode LIKE ?", "%#{@name}%", "%#{@name}%").order('productName').paginate(page: params[:page])  
      else
        # Filter only
        session[:categories] = @filter
        @products = Product.where("productLine in (?)", @filter).order('productName').paginate(page: params[:page])   
      end
    else
      # all products
      session[:categories] = nil
      @products = Product.all.order('productName').paginate(page: params[:page])  
    end

  end

  # GET /products/1
  # GET /products/1.json
  def show
    @line_item = LineItem.new
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:productName, :productLine, :productScale, :productVendor, :productDescription, :quantityInStock, :buyPrice, :MSRP, :search)
    end
end
