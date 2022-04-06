require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    array_of_letters = ('A'..'Z').to_a
    @letters = 10.times.map { array_of_letters.sample }
  end

  def score
    @word = params[:word]
    english = check_if_exist(@word)
    @result = ""
    if english["found"]
      @result = "Congratulations #{@word} exists"
    else
      @result = "Sorry but #{@word} does not seem to be a valid English words"
    end
  end

  def check_if_exist(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    string_serialized = URI.open(url).read
    JSON.parse(string_serialized) # word is a hash, {"found"=>true, "word"=>"orange", "length"=>6}
  end

end
