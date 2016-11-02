class UsersController < ApplicationController

	def profile
		@posts = current_user.posts.page(params[:p_page]).per(5).order('id DESC')
		@replies = current_user.replies.page(params[:r_page]).per(5).order('id DESC')
	end

	def edit
		
	end

	# PATCH /users/:id
	def update
		if params[:_remove_avatar] == "1"
			current_user.avatar = nil
		end		
		current_user.update(user_params)

		redirect_to :action => :profile, :id => current_user
	end

	# GET /users/:id/collection/
	def collection
		@posts = current_user.collected_posts

		# 點擊收藏按鈕時
		if params[:post_id].present?

			@post = Post.find_by_id(params[:post_id])
			if current_user.collected_posts?(@post)
				current_user.collected_posts.delete(@post)
	    else
	      current_user.collected_posts << @post
	    end
		end
    
    # 讀出清單
    respond_to do |format|
    	format.html
    	format.js
    end
  end

	private
	def user_params
		params.require(:user).permit(:name, :email, :avatar, :info)
	
	end

end


