
class Gems < ActiveRecord::Base
	self.table_name = "gems"
	has_many :questions
	has_many :questions_word_count
	has_many :versions
	has_many :commits
end

#issues
class Issue < ActiveRecord::Base
	self.table_name = "issues"
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
class Readme < ActiveRecord::Base
	self.table_name = "readme_word_count"
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
end

#commits
class Commit < ActiveRecord::Base
	self.table_name = "commits"
	belongs_to :gems
end

#contributors
class Contributor < ActiveRecord::Base
	self.table_name = "contributors"
end

#dependencies
class Dependency < ActiveRecord::Base
	self.table_name = "dependencies"
end

#dependencies_development
class DependencyDevelopment < ActiveRecord::Base
	self.table_name = "dependencies_development"
end

#dependencies_runtime
class DependencyRuntime < ActiveRecord::Base
	self.table_name = "dependencies_runtime"
end






