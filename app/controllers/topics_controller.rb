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

		if params[:order]
			case params[:order]
			when 'id'
				sort_by = 'id ASC'
			when 'comments_count'
				sort_by = 'comments_count DESC'
			when 'created_at'
				sort_by = 'created_at DESC'
			when 'last_comment_at'
				sort_by = 'last_comment_at DESC'	
			else 
				sort_by = 'last_comment_at DESC'	
			end
		
      @topics = Topic.order(sort_by).page(params[:page]).per(10)
    else
     	@topics = Topic.order('created_at DESC').page(params[:page]).per(10)
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
		params.require(:topic).permit(:title, :content, :category_ids => [])
	end

	def set_topic
		@topic = Topic.find(params[:id])
	end

end
