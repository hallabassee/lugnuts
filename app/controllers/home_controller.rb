class HomeController < ApplicationController
  
    # GET /home
    def index
        @featured_post = Post.where(:featured => true).first
        @latest_posts = Post.where(:featured => nil).last(3)
        @subscriber = Subscriber.new
    end  
   
    
end