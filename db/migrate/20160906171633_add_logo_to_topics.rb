class AddLogoToTopics < ActiveRecord::Migration[5.0]
  def change
  	add_attachment :topics, :logo
  end
end
