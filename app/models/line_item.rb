class LineItem < ApplicationRecord
    belongs_to :product
    belongs_to :cart

    def total_price
        product.buyPrice * quantity
    end

    def each_price
        product.buyPrice
    end
    
end
