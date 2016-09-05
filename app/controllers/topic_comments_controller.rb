class TopicCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
  	@topic = Topic.find(params[:topic_id])
  	@comment = @topic.comments.new(comment_params)
  	@comment.user = current_user

	  if @comment.save
	    redirect_to topic_path(@topic)
	    flash[:notice] = "感謝你的留言！"
	  else
	    render topic_path(@topic)
	  end
  end


  def destroy
	@topic = Topic.find(params[:topic_id])
	@comment = @topic.comments.find(params[:id])
	@comment.destroy
	redirect_to topic_path(@topic)
	flash[:alert] = "留言已刪除！"
	end

private

  def comment_params
	params.require(:comment).permit(:content, :user_id, :topic_id)
  end

end
