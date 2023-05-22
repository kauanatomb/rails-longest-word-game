class GamesController < ApplicationController
    require "json"
    require "open-uri"

    def new 
        @letters = ('a'..'z').to_a.sample(10)    
    end

    def score
      @word = params[:word]
      url = "https://wagon-dictionary.herokuapp.com/#{@word}"
      open_file = URI.open(url).read
      dictionary = JSON.parse(open_file)
      @letters = params[:letters]

      if dictionary["found"] == false
        @answer = "Sorry but #{@word} does not seem to be a valid English word"
      elsif !includes_in_letters(@word, @letters)
        @answer = "Sorry but #{@word} can't be built out of #{@letters}"
      else
        @answer = "Congratulations! #{@word} is a valid English word"
      end
    end    

    # method to check
    # problem string convert string in array
    # each for string array includes in the array
    # delete letters that includes
    # return true
    def includes_in_letters(string, array)
        string_array = string.chars()
        string_array.each do |i|
            if array.include?(i)
                array.delete(i)
            end
        end
            true
    end
end