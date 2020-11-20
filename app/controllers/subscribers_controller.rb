class SubscribersController < ApplicationController

	def index
	end 

	def create
        @subscriber = Subscriber.new(subscriber_params)

        respond_to do |format|  
        if @subscriber.save  
            @success = true     
            format.js { render 'shared/subscriber_update', locals: {success: @success}}            
        else
            if @subscriber.errors.present?
                @errors = @subscriber.errors
            end
            @success = false
            format.js { render 'shared/subscriber_update', locals: {success: @success, errors: @errors}}
        end  
    end
       
    end

    private

    def subscriber_params
        params.require(:subscriber).permit(:name, :email)
      end

end
