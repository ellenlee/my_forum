class Admin::PostsController < ApplicationController
	before_action :authenticate
	
	layout "admin"


	

  protected


  def authenticate
     authenticate_or_request_with_http_basic do |user_name, password|
         user_name == "admin" && password == "0000"
     end
  end
end
