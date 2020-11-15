class AboutController < ApplicationController

    def index
        @subscriber = Subscriber.new
        @contact = Contact.new
    end 
    
    
end
