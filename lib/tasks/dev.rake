# /lib/tasks/dev.rake
namespace :dev do
  
  desc "Rebuild system"
  task :rebuild => ["db:drop", "db:setup", :fake]
  
  task :fake => :environment do
  		User.delete_all
  		Topic.delete_all
  		Comment.delete_all
  	
	puts "Create fake data for development"
	user = User.create!( :email => "lunacy20@gmail.com", :nickname => 'Ellen', :password => "12345678")
	20.times do |i|
		e = Topic.create( :title => Faker::App.name, :content => Faker::Lorem.sentence(15), :user_id => 1 )
		4.times do |j|
			e.comments.create( :content => Faker::Lorem.sentence(5), :user_id => 1 )
	  	end
	end
  end
end