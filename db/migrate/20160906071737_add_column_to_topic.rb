class AddColumnToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :last_comment_at, :datetime, :default => ""
  	add_column :topics, :comments_count, :integer, :default => "0"
  end
end
