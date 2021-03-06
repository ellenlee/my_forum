class ApiV1::PostsController < ApiController


	def create
		@post = Post.new( :title => params[:title], :content => params[:content] )
		if @post.save
			render :json => {:message =>"OK!"}
		else
			render :json => {:message =>"failed!!"}, :status => 400
		end
	end

	# GET http://localhost:3000/api/v1/posts
	def index
		@posts = Post.all
		render json: @posts.to_json
	end

	# GET http://localhost:3000/api/v1/posts/1
	def show
		@post = Post.find_by(id: params[:id])
		if @post
			# render :json => @post.to_json
		else
			render :json => {:message =>"failed!!"}, :status => 400
		end
	end

	# PATCH http://localhost:3000/api/v1/posts/1.json
	def update
		@user = User.first
		@post = Post.find(params[:id])
		if @post.update(:title => params[:title], :content => params[:content] )
			render :json => { :message => "OK", :post_id => params[:id]}
		else
			render :json => {:message =>"failed!!"}, :status => 400
		end
	end

	def destroy
		@post = Post.find_by_id(params[:id])
		if @post
			@post.destroy
			render :json => { :message => "OK"}
		else
			render :json => {:message =>"failed!!"}, :status => 400
		end
	end

end
