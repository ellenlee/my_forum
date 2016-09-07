class UsersController < ApplicationController

	def profile
		
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


