class Topic < ApplicationRecord
	validates_presence_of :title

	belongs_to :user
	has_many :comments

	has_many :topic_category_ships
	has_many :categories, :through =>:topic_category_ships

	has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/
end
