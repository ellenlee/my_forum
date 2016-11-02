class Admin::UsersController < ApplicationController
	before_action :authenticate
	# before_action :set_category, :only => [ :show, :edit, :update, :destroy ]

	layout "admin"

	def index
		@users = User.all
		
	end

protected

 #  def set_category
	# 	@category = Category.find_by_id(params[:id])
	# end

 #  def category_params
	# 	params.require(:category).permit(:name)
	# end

  def authenticate
     authenticate_or_request_with_http_basic do |user_name, password|
         user_name == "admin" && password == "0000"
     end
  end
end
