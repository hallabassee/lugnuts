class AddFeaturedToProducts < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :featured, :boolean
  end
end
