class HomeController < ApplicationController
  
    # GET /home
    def index
        @featured_post = Post.where(:featured => true).first
        @latest_posts = Post.where(:featured => 0).or(Post.where(:featured => nil)).last(3)
        @featured_product = Product.where(:featured => true).first
        @latest_products = Product.where(:featured => 0).or(Product.where(:featured => nil)).last(4)
        @subscriber = Subscriber.new
    end  
   
    
end