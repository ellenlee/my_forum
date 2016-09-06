class AddColumnToTopic < ActiveRecord::Migration[5.0]
  def change
  	add_column :topics, :last_comment_time, :datetime, :default => ""
  	add_column :topics, :comments_counts, :integer, :default => "0"
  end
end
