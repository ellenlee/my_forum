class AddUserColumnIfAdmin < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :if_admin, :boolean, default: false
  end
end
