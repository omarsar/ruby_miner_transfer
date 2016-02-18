
class Gems < ActiveRecord::Base
	self.table_name = "gems"
	has_many :questions
	has_many :questions_word_count
	has_many :versions
	has_many :commits
	has_many :issues
	has_many :readme_word_count
	has_many :contributors
	has_many :depends
end

#issues
class Issue < ActiveRecord::Base
	self.table_name = "issues"
	belongs_to :gems
end

#questions
class Question < ActiveRecord::Base
	self.table_name = "questions"
	belongs_to :gems
end

#question_word_count
class QuestionsWordCount < ActiveRecord::Base
	self.table_name = "questions_word_count"
	belongs_to :gems
end

#readme_word_count
class ReadmeWordCount < ActiveRecord::Base
	self.table_name = "readme_word_count"
	belongs_to :gems
end

#versions
class Version < ActiveRecord::Base
	self.table_name = "versions"
	belongs_to :gems
	has_many :downloads
end

#downloads
class Download < ActiveRecord::Base
	self.table_name = "downloads"
	belongs_to :versions
end

#commits
class Commit < ActiveRecord::Base
	self.table_name = "commits"
	belongs_to :gems
	has_many :commit_days
end

#commit_days
class CommitDay < ActiveRecord::Base
	self.table_name = "commit_days"
	belongs_to :comits
end

#contributors
class Contributor < ActiveRecord::Base
	self.table_name = "contributors"
	belongs_to :gems
end

#dependencies
class Depend < ActiveRecord::Base
	self.table_name = "depends"
	belongs_to :gems
end

#dependencies_development
class DependencyDevelopment < ActiveRecord::Base
	self.table_name = "dependencies_development"
end

#dependencies_runtime
class DependencyRuntime < ActiveRecord::Base
	self.table_name = "dependencies_runtime"
end






