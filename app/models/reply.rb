class Reply < ApplicationRecord
	validates_presence_of :content, :user_id

  belongs_to :post
  belongs_to :user
end
