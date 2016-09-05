class TopicsController < ApplicationController
	before_action :authenticate_user!, :except => [:index]

	def new
		@topic = Topic.new
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.save

		redirect_to :action => :index
	end

	def index
		@topics = Topic.all
	end

	def show
		@topic = Topic.find(params[:id])
		@comment = Comment.new
	end

private
	def topic_params
		params.require(:topic).permit(:title, :content)
		
	end


end
