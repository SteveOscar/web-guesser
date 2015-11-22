require 'sinatra'
require 'sinatra/reloader'

num = rand(100)

get '/' do
  "The SECRET NUMBER is #{num}"
end
