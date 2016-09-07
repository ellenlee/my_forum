class AddColumnToPost < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :last_reply_at, :datetime, :default => ""
  	add_column :posts, :replies_count, :integer, :default => "0"
  end
end
