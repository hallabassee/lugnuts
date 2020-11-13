class ProductImageMap < ApplicationRecord
    belongs_to :products,  :class_name => "Product", :foreign_key => "productCode", :primary_key => "productCode"

    has_one_attached :image

    def optimized_image(image,x,y)
        return image.variant(resize_to_fill: [x, y]).processed
      end
end
