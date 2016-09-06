class CreateTopicCategoryShips < ActiveRecord::Migration[5.0]
  def change
    create_table :topic_category_ships do |t|
      t.integer :topic_id
      t.integer :category_id

      t.timestamps
    end
    add_index :topic_category_ships, :topic_id
    add_index :topic_category_ships, :category_id
  end
end
