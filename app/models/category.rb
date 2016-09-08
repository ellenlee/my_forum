class Category < ApplicationRecord
	validates_presence_of :name

	has_many :post_categoryships, :dependent => :destroy
	has_many :posts, :through =>:post_categoryships

end
