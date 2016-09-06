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
		  e = Topic.create( :title => Faker::Lorem.sentence, :content => Faker::Lorem.sentence(15), :user_id => 1 )
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(5), :user_id => 1)
		  end
		  2.times do |j|
				e.comments.create( :content => Faker::Lorem.sentence(7), :user_id => 2)
		  end
	  end
	  
	  10.times do |i|
		  e = Topic.create( :title => Faker::Lorem.sentence, :content => Faker::Lorem.sentence(15), :user_id => 2 )
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
	  	t.last_comment_at = t.comments.last.created_at
	  	t.comments_count = t.comments.size
	  	t.save
	  end
  end

# 寫一個 rake 抓取 API 資料，並開一個對應的 model (ApiDemo)存進資料庫裡面
# 進一步讓這個 rake 可以重複執行，不會重複新增資料。也就是如果有相同的 id 進行更新，沒有才新增資料。

  task :mrt => :environment do

  	url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=ddb80380-f1b3-4f8e-8016-7ed9cba571d5"

  	json_string = RestClient.get(url)
  	data = JSON.parse(json_string)

  	puts "ready to use MRT API"
  	@count = 0	
  	data["result"]["results"].each do |u|
		
  		existing = ApiDemo.find_by_raw_id(u["_id"])

  		if existing
  			#update
  		else
  			ApiDemo.create(:raw_id => u["_id"], :name => u["sna"], :address =>u["ar"], :area => u["sarea"])
  			puts "#{u["_id"]} : #{u["sna"]}"
  			@count += 1
  		end
  		 
  	end
  	puts "-----"
  	puts "共 #{@count} 筆資料新增"
  end
end