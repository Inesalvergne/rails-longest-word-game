require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    array_of_letters = ('A'..'Z').to_a
    @letters = 10.times.map { array_of_letters.sample }
  end

  def score
    @word = params[:word]
    @result = ""
    english = check_if_exist(@word)
    exist = in_grid?(@word)

    if english["found"] && exist == true
      @result = "Congratulations! #{@word} is a valid English word!"
    elsif exist == false
      @result = "Sorru but #{@word} can't be built out of #{@letters}"
    else
      @result = "Sorry but #{@word} does not seem to be a valid English words"
    end
  end

  def check_if_exist(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    string_serialized = URI.open(url).read
    JSON.parse(string_serialized) # word is a hash, {"found"=>true, "word"=>"orange", "length"=>6}
  end

  def in_grid?(attempt)
    # not working
    word = attempt.chars
    word.all? do |letter|
      @letters.include?(letter.upcase) && word.count(letter) <= grid.count(letter.upcase)
    end
  end
end
