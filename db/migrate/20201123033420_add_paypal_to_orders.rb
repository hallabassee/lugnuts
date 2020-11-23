class AddPaypalToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :paid, :boolean, :default => false
    add_column :orders, :token, :string
  end
end
