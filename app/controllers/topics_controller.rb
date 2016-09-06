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
		@topics = Topic.all
		@topics = Topic.page(params[:page]).per(10)
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
		params.require(:topic).permit(:title, :content)
	end

	def set_topic
		@topic = Topic.find(params[:id])
		
	end

end
