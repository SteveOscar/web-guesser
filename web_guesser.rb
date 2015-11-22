require 'sinatra'
require 'sinatra/reloader'
require 'pry'

number = rand(100)

get '/' do
  guess = params["guess"].to_i
  message = check_guess(guess, number)
  erb :index, :locals=> {:number => number, :message => message}
end

def check_guess(guess, number)
message =  "Too low" if guess < number && (number - guess) <= 5
message =  "Way too low" if guess < number && (number - guess) > 5
message =  "Too high" if guess > number && (guess - number) <= 5
message =  "Way too high" if guess > number && (guess - number) > 5
message =  "The SECRET NUMBER is #{number}" if guess ==  number
message
end
