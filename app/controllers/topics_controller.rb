class TopicsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		if @topic.save
			redirect_to topics_path
			flash[:notice] = "新增成功"
		else
			render :action => :new
		end
	end

	def index
		# @category = Category.find(params[:id])
		# @topics = Topic.order_the_list(params[:order], params[:page])		
 
 		if params[:category].present?
 			@category = Category.find(params[:category])
 			@page_title = @category.name
			@topics = @category.topics.order('id DESC').page(params[:page]).per(10)
		else
			@page_title = "XXX 課程中心"	
			@topics = Topic.order('id DESC').page(params[:page]).per(10)
		end

		if params[:order]
			@topics = @topics.order("#{params[:order]} DESC").page(params[:page]).per(10)
		else
			@topics.order('id DESC')
		end
	end


	def show
		set_topic
		@comment = Comment.new
	end

	def edit
		set_topic
	end

	def update
		set_topic
		if params[:_remove_logo] == "1"
			@topic.logo = nil
		end

		@topic.update(topic_params)

		redirect_to :action => :show, :id => @topic
	end

	def destroy
		set_topic
		@topic.destroy

		redirect_to :action => :index
	end

	private
	def topic_params
		params.require(:topic).permit(:title, :content, :logo, :category_ids => [])
	end

	def set_topic
		@topic = Topic.find(params[:id])
	end

end
