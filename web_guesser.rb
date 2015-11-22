require 'sinatra'
require 'sinatra/reloader'
require 'pry'


number = rand(100)
countdown = 6

get '/' do
  cheat_mode = params["cheat"]
  guess = params["guess"].to_i
  message = check_guess(guess, number, countdown)
  cheat = "Correct answer is #{number}" if cheat_mode == "true"
  color = styling(message)
  countdown = number_count(countdown, color)
  number = rand(100) if countdown == 0 || color == "Green"
  erb :index, :locals=> {:number => number, :message => message,
                         :color => color, :countdown => countdown, :cheat => cheat}
end

def check_guess(guess, number, countdown)
  message = "Too low" if guess < number && (number - guess) <= 5
  message = "Way too low" if guess < number && (number - guess) > 5
  message = "Too high" if guess > number && (guess - number) <= 5
  message = "Way too high" if guess > number && (guess - number) > 5
  message = "The SECRET NUMBER is #{number}. New Game." if guess ==  number
  message = "Out of guesses, new game" if countdown == 1
  message = "Guess a number between 1 - 100" if guess == 0
  message
end

def styling(message)
  color = "OrangeRed" if message == "Way too low" || message == "Way too high"
  color = "PeachPuff" if message == "Too low" || message == "Too high"
  color = "Green" if message.include?("SECRET")
  color
end

def number_count(number, color)
number = (number - 1)  if number > 0
number = 5 if number == 0 || color == "Green"
number
end
