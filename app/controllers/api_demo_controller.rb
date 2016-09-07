class ApiDemoController < ApplicationController

	def index
		
	end

	def show
		@test = 123
		respond_to do |format|
  		format.html {render :layout => false}
  		format.json {
  			render :json => { :title => Time.now}
  		}
  		format.js 
	
	end
		
	end

end
