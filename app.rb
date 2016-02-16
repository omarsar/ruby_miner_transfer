require 'sinatra' 
require 'sinatra/activerecord'


class Gemas < ActiveRecord::Base
	self.table_name = "gems"
end


@gems = Gemas.all()

puts (@gems)

puts "We have reached the end of app!!!"