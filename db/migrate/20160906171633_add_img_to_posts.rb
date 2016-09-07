class AddImgToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :posts, :img
  end
end
