class PostRepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
  	@reply = @post.replies.new(reply_params)
  	@reply.user = current_user

	  if @reply.save
			post_replies_info_update

	    redirect_to post_path(@post)
	    flash[:notice] = "感謝你的留言！"
	  else
	    render post_path(@post)
	  end
  end

  def destroy
		@reply = @post.replies.find(params[:id])
		if @reply.user != current_user
			
			render post_path(@post)
			flash[:alert] = "你不是作者，沒有權限！"
		else
			@reply.destroy
		end

		post_replies_info_update

		respond_to do |format|
			format.html 
			format.js
		end	
	end

	private

	def set_post
		@post = Post.find_by_id(params[:post_id])
	end

  def reply_params
		params.require(:reply).permit(:content, :user_id, :post_id)
  end

  def post_replies_info_update
  	# event = self.event
  	@post.last_reply_at = @reply.created_at
		@post.replies_count = @post.replies.size
		# +1
		#evet...at = self.created.at
		@post.save
		# 寫在model
  end

end

