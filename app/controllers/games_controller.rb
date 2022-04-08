require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    array_of_letters = ('A'..'Z').to_a
    @letters = 10.times.map { array_of_letters.sample }
  end

  def check_if_exist(attempt)
    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    string_serialized = URI.open(url).read
    JSON.parse(string_serialized) # word is a hash, {"found"=>true, "word"=>"orange", "length"=>6}
  end

  def in_grid?(word)
    word = word.chars
    word.all? { |l| @letters.to_a.include?(l) }
  end

  def score
    @word = params[:word]
    @letters = params[:letters].downcase.split(' ')
    @result = ''
    english = check_if_exist(@word)

    if in_grid?(@word) && (english["found"] == true)
      @result = "Congratulations! #{@word} is a valid English word!"
    elsif english["found"] == false
      @result = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @result = "Sorry but #{@word} can't be built out of #{@letters.join(', ').upcase}"
    end
  end

end
