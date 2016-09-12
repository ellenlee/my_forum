class Admin::CategoriesController < ApplicationController
	before_action :authenticate
	before_action :set_category, :only => [ :show, :edit, :update, :destroy ]

	
	layout "admin"

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(category_params)
		
		if @category.save
			redirect_to admin_categories_path
			flash[:notice] = "新增成功"
		else
			render :action => 'admin/categories#new'
		end
	end

	def index
		@categories = Category.all
		if params[:id]
      set_category
    else
      @category = Category.new
    end
	end

	def update
		@category.update(category_params)
		redirect_to admin_categories_path
		flash[:notice] = "修改成功"
	end


	def destroy
		set_category
		@category.destroy
		redirect_to admin_categories_path
		flash[:alert] = "分類已刪除"
	end


	protected

  def set_category
		@category = Category.find_by_id(params[:id])
	end

  def category_params
		params.require(:category).permit(:name)
	end

  def authenticate
     authenticate_or_request_with_http_basic do |user_name, password|
         user_name == "admin" && password == "0000"
     end
  end

end
