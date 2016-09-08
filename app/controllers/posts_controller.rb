class PostsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :set_post, :only => [ :show, :edit, :update, :destroy ]

	# GET /posts/new
	def new
		@post = Post.new
	end

	# POST /posts/
	def create
		@post = Post.new(post_params)
		@post.user = current_user

		if @post.save
			redirect_to post_path(@post)
			flash[:notice] = "新增成功"
		else
			render :action => :new
		end
	end

	# GET /posts/
	def index 
 		if params[:category].present?
 			@category = Category.find(params[:category])
 			@page_title = @category.name
			@posts = @category.posts
		else
			@page_title = "專案實作學習中心"	
			@posts = Post.all
		end

		if params[:order]
			@posts = @posts.order(params[:order].to_sym => :DESC)
		else
			@posts = @posts.order('id DESC')
		end
		prepare_variable_for_template
	end

	# GET /posts/:id/
	def show
		@reply = Reply.new

		@post.viewed_count += 1
		@post.save
	end

	# GET /posts/:id/edit
	def edit
		if @post.user != current_user
			flash[:alert] = "你不是作者，沒有權限！"
			redirect_to post_path(@post)
		end
	end

	# PATCH /posts/:id/
	def update
		if params[:_remove_img] == "1"
			@post.img = nil
		end
		@post.update(post_params)

		redirect_to :action => :show, :id => @post
	end

	# DELETE /posts/:id/
	def destroy
		if @post.user != current_user
			flash[:alert] = "你不是作者，沒有權限！"
			redirect_to post_path(@post)
		else
			@post.destroy
		end
		redirect_to :action => :index
	end

	private

	def post_params
		params.require(:post).permit(:title, :content, :img, :category_ids => [])
	end

	def set_post
		@post = Post.find_by_id(params[:id])
	end

	def prepare_variable_for_template
		@posts = @posts.page(params[:page]).per(10)
	end
end
