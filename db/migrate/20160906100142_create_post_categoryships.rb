class CreatePostCategoryships < ActiveRecord::Migration[5.0]
  def change
    create_table :post_categoryships do |t|
      t.integer :post_id
      t.integer :category_id

      t.timestamps
    end
    add_index :post_categoryships, :post_id
    add_index :post_categoryships, :category_id
  end
end
