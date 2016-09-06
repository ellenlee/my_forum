class Topic < ApplicationRecord
	validates_presence_of :title

	belongs_to :user
	has_many :comments

	has_many :topic_category_ships
	has_many :categories, :through =>:topic_category_ships
end
