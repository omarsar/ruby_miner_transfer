#User Sinatra for in case there is a need for a web app
require 'sinatra' 
require 'sinatra/activerecord'
require './config/models'


@gem = Gems.create(name: 'Elvis_gem', commits_count: 25, forks_count: 30, issues_count: 366, 
	last_commit: 455, repo_name: "elvis", repo_username: "elvistest", stars: 13, total_downloads: 1222)
#puts @gem.id
#Note: Here I can do bulk insert (1000 limit)
@questions = @gem.questions.create([{title: ['What','test']}, {title: ['the','one']} ])
@question_word_count = @gem.questions_word_count.create([{term: "test", count: 25}])
@vers = @gem.versions.create([{:num => "0.2", :downloads => 30}, {:num => "0.3", :downloads => 30}])
@downloads = @vers.create()
# =>>>>>>>>>>>>add the other things for versions here








#testing the models
=begin
@gems = Gemas.all()

@gems.each do |t|
	puts t.name
	t.questions.each do |q|
		puts q.title 
	end
end
=end

puts "We have reached the end of app!!!"