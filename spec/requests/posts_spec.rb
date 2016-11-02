require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET api/v1/posts/:id" do

  	before do
  		@user = User.create(:name => "xxx", :email=> "lunacy20@gmail.com", :password => "1234567")
  		@post = Post.create(:title =>"xxx", :user_id => @user.id)
  	end

  	# show
    it "should get correct post and have 200 code" do 
      get "/api/v1/posts/#{@post.id}.json"

      data = JSON.parse(@post)

      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)).to eq(data)
    end
  end

  # new
  describe "POST /api/v1/posts" do

  	it "should successfully create new post" do
  		params = {:title => "xxx", :content => "sdfs"}
  		post "/api/v1/posts",:params => params

  		expect(response).to have_http_status(200)
  		expect(Post.count).to eq(1)
  	end
	end

	# update
	describe "PATCH /api/v1/posts" do

		it "should change substance of the post" do
			parmas = { :title => "xxx", :content => "sdfs", :user_id => @user.id }
			#response.body
			JSON.parse(response.body)["event"]["name"]
		end
	end
end
