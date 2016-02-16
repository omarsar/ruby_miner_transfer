#User Sinatra for in case there is a need for a web app
require 'sinatra' 
require 'sinatra/activerecord'
require './config/models'


@gems = Gemas.all()

@gems.each do |t|
	puts t.name
end

puts "We have reached the end of app!!!"