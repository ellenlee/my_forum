class LikesController < ApplicationController

	def create
		@post = Post.find_by_id(params[:id])
		current_user.liked_posts << @post

		respond_to do |format|
			format.js {render :template => 'likes/likes'}
		end
	end

	def destroy
		@post = Post.find_by_id(params[:id])
		current_user.liked_posts.delete(@post)
	
		respond_to do |format|
			format.js {render :template => 'likes/likes'}
		end
	end
end

