class Post < ApplicationRecord
	validates_presence_of :title, :user_id

	belongs_to :user

	has_many :replies
	has_many :post_categoryships, :dependent => :destroy
	has_many :categories, :through =>:post_categoryships

	has_many :like, :dependent => :destroy
  has_many :liked_posts, :through => :like, :source => :user

	has_attached_file :img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :img, content_type: /\Aimage\/.*\z/
end
