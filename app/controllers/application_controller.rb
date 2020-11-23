class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :current_shopping_cart
    helper_method :is_admin!

    def current_shopping_cart
      if current_user
        self.add_guest_cart_to_logged_in_user
        @shopping_cart = current_user.cart
      else
        if session[:shopping_cart]
          @shopping_cart = Cart.find(session[:shopping_cart])
        else
          @shopping_cart = Cart.create 
          session[:shopping_cart] = @shopping_cart.id
        end
      end
    end


    protected

    def configure_permitted_parameters
      added_attrs = %i[username email password password_confirmation remember_me avatar]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
  
    private
  
    def is_admin!
      if current_user&.admin
      else
        redirect_to root_path
      end
    end

    def add_guest_cart_to_logged_in_user
      if session[:shopping_cart]
        user_cart = Cart.where("user_id" => current_user.id).first
        if user_cart
          LineItem.where(:cart_id => session[:shopping_cart]).update_all(cart_id: user_cart.id)
          Cart.where(:id => session[:shopping_cart]).destroy_all
        else
          guest_cart = Cart.find(session[:shopping_cart])     
          guest_cart.update_column("user_id", current_user.id)
        end
        session[:shopping_cart] = nil 
      end
    end

  end
