# /lib/tasks/dev.rake
namespace :dev do
  
  desc "Rebuild system"
  task :rebuild => ["db:drop", "db:setup", :fake]
  
  task :fake => :environment do
		User.delete_all
		Topic.delete_all
		Comment.delete_all
  	
		puts "Create fake data for development"
		# 產生初始假資訊
		user = User.create!( :email => "root@example.com", :name => 'root', :password => "12345678")
		user2 = User.create!( :email => "lunacy20@example.com", :name => 'ellen', :password => "12345678")
		5.times do |i|
		  e = Topic.create( :title => Faker::App.name, :content => Faker::Lorem.sentence(15), :user_id => 1 )
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(5), :user_id => 1 )
		  end
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(7), :user_id => 2 )
		  end
	  end
	  
	  10.times do |i|
		  e = Topic.create( :title => Faker::App.name, :content => Faker::Lorem.sentence(15), :user_id => 2 )
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(5), :user_id => 1 )
		  end
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(7), :user_id => 2 )
		  end
	  end

	  # 更新 topic - comments 資訊
	  puts "topic comments info update"
	  Topic.all.each do |t|
	  	t.last_comment_time = t.comments.last.created_at
	  	t.comments_counts = t.comments.size
	  	t.save
	  end
  
  end
end