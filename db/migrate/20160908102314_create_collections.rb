class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|

    	t.integer :post_id
    	t.integer :user_id

      t.timestamps
    end
  add_index :collections, :post_id
  add_index :collections, :user_id
  end
end
