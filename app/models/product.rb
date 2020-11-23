class Product < ApplicationRecord
    self.primary_key = "productCode"
    self.per_page = 12
    has_one :product_image_map, :class_name => "ProductImageMap", :foreign_key => "productCode", :primary_key => "productCode"
    has_many :line_items
    has_many :orders, through: :line_items
    before_destroy :ensure_not_referenced_by_any_line_item
     
private
# ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
        unless line_items.empty?
            errors.add(:base, 'Line Items present')
            throw :abort
        end
    end
    
end
