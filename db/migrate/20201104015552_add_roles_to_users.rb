class AddRolesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :member, :boolean, default: false

    User.create! do |u|
      u.email     = 'test_admin@test.com'
      u.password  = 'password'
      u.admin     = true
    end
  end
end
