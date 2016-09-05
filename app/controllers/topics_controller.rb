class TopicsController < ApplicationController

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

private
	def topic_params
		params.require(:topic).permit(:title, :content)
		
	end


end
