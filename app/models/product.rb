class Product < ApplicationRecord
    self.primary_key = "productCode"
    self.per_page = 12
    has_one :product_image_map, :class_name => "ProductImageMap", :foreign_key => "productCode", :primary_key => "productCode"
end
