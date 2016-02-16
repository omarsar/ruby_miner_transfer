#gems (Note: could not use Gem/s as model name, it is already reserved)
class Gemas < ActiveRecord::Base
	self.table_name = "gems"
end

#issues
class Issue < ActiveRecord::Base
	self.table_name = "issues"
end

#questions
class Question < ActiveRecord::Base
	self.table_name = "questions"
end

#question_word_count
class Question_Word_Count < ActiveRecord::Base
	self.table_name = "questions_word_count"
end

#readme_word_count
class Readme < ActiveRecord::Base
	self.table_name = "readme_word_count"
end

#versions
class Version < ActiveRecord::Base
	self.table_name = "versions"
end

#commits
class Commit < ActiveRecord::Base
	self.table_name = "commits"
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
class Dependency_Development < ActiveRecord::Base
	self.table_name = "dependencies_developmentn"
end

#dependencies_runtime
class Dependency_Runtime < ActiveRecord::Base
	self.table_name = "dependencies_runtime"
end

#downloads
class Download < ActiveRecord::Base
	self.table_name = "downloads"
end





