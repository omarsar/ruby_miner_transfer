require 'sinatra' 
require 'sinatra/activerecord'

#Activerecord schema for rubyminer project
ActiveRecord::Schema.define do
	
	#Table: Gem
	create_table "gems" do |t|
		t.string "name"
		t.string "repo_name"
		t.string "repo_username"
		t.datetime "created_at"
		t.integer "commits"
		t.integer "forks"
		t.integer "issues"
		t.string "ranking"
		t.integer "stars"
		t.integer "last_commit"
		t.integer "total_downloads"
	end

	#Table: Commit (commit_activity_last_year)
	#Option B: t.json "commit_activity_last_year (simple but not optimal solution)	
	create_table "commits" do |t|
		t.integer "gemas_id"
		t.integer "total"
		t.string "week"
		t.string "days", array: true
	end

	#Table: Dependency (dependencies)
	create_table "dependencies" do |t|
		t.integer "gemas_id"
		t.integer "dependency_id"		
		#consider the extra two tables or just introduce a type column
		t.string "type"
		t.string "name"
		t.string "requirements"
	end

	#Table: Dependency(Development)
	#create_table "dependencies_development" do |t|
	#	t.integer "dependency_id"
	#	t.string "name"
	#	t.string "requirements"
	#end

	#Table: Dependency(Runtime)
	#create_table "dependencies_runtime" do |t|
	#	t.integer "dependency_id"
	#	t.string "name"
	#	t.string "requirements"
	#end
	
	#Table: Question
	create_table "questions" do |t|
		t.integer "gemas_id"
		t.datetime "creation_date"
		t.integer "views"
		t.string "title", array: true
	end

	#Table: Question Word Count (questions_word_count)
	create_table "questions_word_count" do |t|
		t.integer "gemas_id"
		t.string "term"
		t.integer "count"
	end

	#Table: Readme Word Count (readme_word_count)
	create_table "readme_word_count" do |t|
		t.integer "gemas_id"
		t.string "term"
		t.integer "count"
	end

	#Table: Issue
	create_table "issues" do |t|
		t.integer "gemas_id"
		t.integer "num"
		t.datetime "created_at"
		t.datetime "closed_at"
		t.integer "duration"
	end

	#Table: Contributor
	#Optimization issues: There will be repeated rows of contributors name if
	#these contributors are part of other gem contributers pool.
	create_table "contributors" do |t|
		t.integer "gemas_id"
		t.integer "contributions"
		t.string "name"
	end

	#Table: Version (version_downloads)
	create_table "vers" do |t|
		t.integer "gemas_id"
		t.string "num"
		t.integer "downloads"
	end

	#Table: Download (version_downloads_days)
	create_table "downloads" do |t|
		t.integer "vers_id"
		t.datetime "download_date"
		t.integer "downloads"
	end

end
