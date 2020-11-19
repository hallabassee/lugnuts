class SubscribersController < ApplicationController

	def index
	end 

	def create
        @subscriber = Subscriber.new(subscriber_params)

        respond_to do |format|  
        if @subscriber.save  
            @success = true     
            format.js { render 'home/index_update', locals: {success: @success}}            
        else
            @success = false
            format.js { render 'home/index_update', locals: {success: @success} }
        end  
    end
       
    end

    private

    def subscriber_params
        params.require(:subscriber).permit(:name, :email)
      end

end
