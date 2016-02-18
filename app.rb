#User Sinatra for in case there is a need for a web app
require 'sinatra' 
require 'sinatra/activerecord'
require './config/models'
require 'mongo'

#setup mongo connection
client = Mongo::Client.new(['127.0.0.1:27017'], :database => 'gems_info')

#Needed because of conversion of original creation_date(int) format
def insert_question(q, g)
	q_f = []
	q.each do |question|
		q_f << {
			'creation_date' => Time.at(question['creation_date']),
			'title' => question['title'],
			'views' => question['views']
		}
	end

	g.questions.create(q_f)
end

#insert word count obtained from questions separately into a table
def insert_questions_word_count(qw, g)
	qw_f = []
	qw.each do |qword|
		qw_f << {
			'term' => qword[0],
			'count' => qword[1]
		}
	end

	g.questions_word_count.create(qw_f)
end

#insert daily version downloads information
def insert_version_downloads_days(vdd, vn ,vs)
	vdd_f = []
	vdd.each do |vd|
		vdd_f << {
			'download_date' => vd[0],
			'version_num' => vn,
			'day_index' => 1, #this has to be calculated as well
			'daily_downloads' => vd[1]
		}
	end

	vs.downloads.create(vdd_f)
	puts "vdd days function"
end

#function to insert version download information
def insert_versions(v,vd,g)
	v_f = []
	index = 0

	v.each do |version|
		v_f << {
			'version_num' => version['number'],
			'total_downloads' => version['downloads']
		}
	end

	#insert per single rather than by batch to be able to populate the downloads days table
	v_f.each do |vs|
		@v = g.versions.create(vs)
		#we can use below if we want to include more on the table
		insert_version_downloads_days(vd[index]['downloads_date'],vs['version_num'],@v)
		index = index+1
	end
end

#insert the commits per day records
def insert_commit_days(cpd, cw, cs)
	cd_f = []
	d_index = 0

	cpd.each do |cd|
		cd_f << {
			'week_index' => cw,
			'day_index' => d_index,
			'daily_commits' => cd 
		}
		d_index = d_index+1
	end

	cs.commit_days.create(cd_f)
end


#function to store commits activity for the last year
def insert_commits(c, g)
	c_f = []
	w_index = 0

	c.each do |commit|
		c_f << {
			'week' => commit['week'] ,
			'week_index' => w_index ,
			'total_commits' => commit['total'] 
		}
		w_index = w_index+1
	end

	w_index = 0
	c.each do |cs|
		@c = g.commits.create(c_f[w_index])
		insert_commit_days(cs['days'], w_index ,@c)
		w_index = w_index+1
	end
	
end

#To insert issues information
def insert_issues(i, g)
	i_f = []
	i.each do |issue|
		i_f << {
			'issue_num' => issue['number'],
			'created_at' => issue['created_at'],
			'closed_at' => issue['closed_at'],
			'duration' => issue['duration'] 
		}
	end

	g.issues.create(i_f)
end

#to insert the read me for word cloud
def insert_readme(r,g)
	r_f = []
	r.each do |word|
		r_f << {
			'term' => word[0],
			'count' => word[1]
		}
	end

	g.readme_word_count.create(r_f)
end

#to insert contributors information
def insert_contributors(c, g)
	c_f = []
	c.each do |contributor|
		c_f << {
			'contributions' => contributor['contributions'],
			'name' => contributor['name']
		}
	end

	g.contributors.create(c_f)
end

#to insert development dependencies
def insert_development_dependencies(dd, g)
	dd_f = []
	dd.each do |dependency|
		dd_f << {
			'name' => dependency['name'],
			'requirements' => dependency['requirements'],
			'category' => "development"
		}
	end

	g.depends.create(dd_f)
end

#to insert runtime dependencies
def insert_runtime_dependencies(dd, g)
	dd_f = []
	dd.each do |dependency|
		dd_f << {
			'name' => dependency['name'],
			'requirements' => dependency['requirements'],
			'category' => "runtime"
		}
	end

	g.depends.create(dd_f)
end

#Function to insert JSON docs to PSQL DB
def insert_one(doc)
	@gem = Gems.create(
		name: doc['name'], 
		commits_count: doc['commits'], 
		forks_count: doc['forks'], 
		issues_count: doc['issues'], 
		last_commit: doc['last_commit'], 
		repo_name: doc['repo_name'], 
		created_at: doc['created_at'],
		repo_username: doc['repo_username'], 
		stars: doc['stars'], 
		ranking: doc['ranking'],
		total_downloads: doc['total_downloads'])
	
	insert_question(doc['questions'], @gem)
	insert_questions_word_count(doc['questions_word_count'], @gem)
	insert_versions(doc['version_downloads'], doc['version_downloads_days'], @gem)
	insert_commits(doc['commit_activity_last_year'], @gem)
	insert_issues(doc['issues_info'], @gem)
	insert_readme(doc['readme_word_count'], @gem)
	insert_contributors(doc['contributors'], @gem)
	insert_development_dependencies(doc['dependencies']['development'], @gem)
	insert_runtime_dependencies(doc['dependencies']['runtime'], @gem)
end

#TODO: need to fetch by batches (for now it is the entire 100 gems)
documents =  []
client['gems'].find.each do |document|
	documents << document
end

doc = documents[92]
insert_one(doc)

#Note: It takes approx. two minutes per gem.

puts "We have reached the end of insertion!!!"