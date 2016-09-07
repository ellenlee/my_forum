class PostCategoryship < ApplicationRecord
	validates_presence_of :post_id, :category_id

	belongs_to :post
	belongs_to :category
end
