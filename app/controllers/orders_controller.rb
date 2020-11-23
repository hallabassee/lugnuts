class OrdersController < ApplicationController
  # include CurrentCart
  skip_before_action :verify_authenticity_token
  before_action :paypal_init, :only => [:create_order, :capture_order]

  before_action :set_cart, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new  
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @@no_of_lines = 0

    respond_to do |format|
      if @order.save
        @cart.line_items.each do |line_item|
          @@no_of_lines += 1
          @order.orderdetails.insert(
            orderNumber: @order.orderNumber,
            quantityOrdered: line_item.quantity,
            productCode: line_item.product_id,  
            priceEach: line_item.each_price,
            orderLineNumber: @@no_of_lines
          )
        end
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        format.html { redirect_to products_path, notice:
          'Thank you for your order.' }
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # paypal
  def create_order
    price = 100.90
    request = PayPalCheckoutSdk::Orders::OrdersCreateRequest::new
    request.request_body({
      :intent => 'CAPTURE',
      :purchase_units => [
        {
          :amount => {
            :currency_code => 'USD',
            :value => price
          }
        }
      ]
    })
    begin
      response = @client.execute request

      # create customer record
      customer = Customer.new
      customer.customerName = current_user.username
      customer.contactLastName = Faker::Name.first_name
      customer.contactFirstName = Faker::Name.last_name
      customer.phone = Faker::PhoneNumber.cell_phone
      customer.addressLine1 = Faker::Address.street_address
      customer.city = Faker::Address.city
      customer.country = Faker::Address.country
      customer.save

      # create order record
      order = Order.new
      order.token = response.result.id
      order.orderDate = Date.today
      order.requiredDate = Date.today + 10.days
      order.status = 'In Process'
      order.comments = 'Online order'
      order.customerNumber = customer.customerNumber

      if order.save
        return render :json => {:token => response.result.id}, :status => :ok
      end

    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end  
  end

  def capture_order
      request = PayPalCheckoutSdk::Orders::OrdersCaptureRequest::new params[:order_id]
    begin
      response = @client.execute request
      order = Order.find_by :token => params[:order_id]
      order.paid = response.result.status == 'COMPLETED'

      # ADD ORDER DETAIL RECORDS

      if order.save
        return render :json => {:status => response.result.status}, :status => :ok
      end
    rescue PayPalHttp::HttpError => ioe
      # HANDLE THE ERROR
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:orderDate, :requiredDate, :shippedDate, :status, :comments, :customerNumber, :paid, :token )
    end

  private
    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to products_url, notice: 'Your cart is empty'
      end
    end

    def paypal_init
      client_id = 'ATnl6_yOGNWRfY40cWNC_Yx9xTGM2vR8SOJTvWh19zGupWID4DG9BiGg-e8vOoJ3CTiLnAMm-OM-7g4s'
      client_secret = 'EIC2FLDYk2zgFGA87Lv32iwW8Bzq8kSTl5oOJ6d70Tz2IMRRIa_cR7zB8OoGUAyJHbpwxJKKuYw9MPRu'
      environment = PayPal::SandboxEnvironment.new client_id, client_secret
      @client = PayPal::PayPalHttpClient.new environment
    end
  
end