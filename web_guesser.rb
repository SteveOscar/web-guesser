require 'sinatra'
require 'sinatra/reloader'
require 'pry'

number = rand(100)


get '/' do

  guess = params["guess"].to_i
  message = check_guess(guess, number)
  color = styling(message)
  erb :index, :locals=> {:number => number, :message => message, :color => color}
end

def check_guess(guess, number)
  message = "Too low" if guess < number && (number - guess) <= 5
  message = "Way too low" if guess < number && (number - guess) > 5
  message = "Too high" if guess > number && (guess - number) <= 5
  message = "Way too high" if guess > number && (guess - number) > 5
  message = "The SECRET NUMBER is #{number}" if guess ==  number
  message = "Guess a number between 1 - 100" if guess == 0
  message
end

def styling(message)
  color = "OrangeRed" if message == "Way too low" || message == "Way too high"
  color = "PeachPuff" if message == "Too low" || message == "Too high"
  color = "Green" if message.include?("SECRET")
  color
end
