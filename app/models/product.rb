class Product < ApplicationRecord
    self.primary_key = "productCode"
    has_one_attached :image
  
    self.per_page = 10
  
    def optimized_image(image,x,y)
      return image.variant(resize_to_fill: [x, y]).processed
    end

end
