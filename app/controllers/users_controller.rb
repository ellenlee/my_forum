class UsersController < ApplicationController

	def profile
		@topics = current_user.topics.page(params[:t_page]).per(5).order('id DESC')
		@comments = current_user.comments.page(params[:c_page]).per(5).order('id DESC')
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

private
	def user_params
		params.require(:user).permit(:name, :email, :avatar, :info)
	
	end

end


