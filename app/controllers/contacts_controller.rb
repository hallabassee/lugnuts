class ContactsController < ApplicationController

    def index
    end 

    def create
        @contact = Contact.new(contact_params)
        respond_to do |format|  
            if @contact.save  
                @success = true     
                format.js { render 'about/post_update', locals: {success: @success} }            
            else
                @success = false
                format.js { render 'about/post_update', locals: {success: @success} }
            end  
        end       
    end

    private

    def contact_params
        params.require(:contact).permit(:name, :email, :body)
    end

    
end
