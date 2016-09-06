class CreateApiDemos < ActiveRecord::Migration[5.0]
  def change
    create_table :api_demos do |t|

    	t.integer :raw_id
    	t.string :name #捷運站名稱（sna）
    	t.string :area #地區(sarea)
    	t.string :address #地址(ar)

      t.timestamps
    end
  end
end
