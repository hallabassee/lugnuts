class AddAutoincrementToCustomers < ActiveRecord::Migration[6.0]
  def change
    ActiveRecord::Base.connection.execute 'SET FOREIGN_KEY_CHECKS=0;'
    change_column :customers, :customerNumber, :integer, auto_increment: true
    ActiveRecord::Base.connection.execute 'SET FOREIGN_KEY_CHECKS=1;'
  end
end
