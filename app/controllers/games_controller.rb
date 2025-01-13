class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split(" ")
    @word = params[:word].upcase
    url = "https://dictionary.lewagon.com/#{@word}"
    response = URI.open(url).read
    @parsed_word = JSON.parse(response)

    if @parsed_word["found"] == false
      @message = "Sorry but #{@parsed_word["word"].upcase} does not seem to be a valid English word..."
    elsif @parsed_word["found"] == true && @word.chars.all? { |letter| @letters.include?(letter) }
      @message = "Congratulations! #{@parsed_word["word"].upcase} is a valid English word!"
    else
      @message = "Sorry but #{@parsed_word["word"].upcase} can't be built out of #{@letters.join(" ")}"
    end
  end
end
