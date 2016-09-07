class AddUserProfileElement < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :info, :text
  	add_attachment :users, :avatar
  end
end
