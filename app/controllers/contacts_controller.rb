class ContactsController < ApplicationController

    def index
    end 

    def create
        @contact = Contact.new(contact_params)

        respond_to do |format|  
            if @contact.save && verify_recaptcha(model: @contact)
                @success = true     
                format.js { render 'about/post_update', locals: {success: @success} }            
            else
                @success = false
                if @contact.errors.present?
                    @errors = @contact.errors
                end
                format.js { render 'about/post_update', locals: {success: @success, errors: @errors} }
            end  
        end       
    end

    private

    def contact_params
        params.require(:contact).permit(:name, :email, :body)
    end

    
end
