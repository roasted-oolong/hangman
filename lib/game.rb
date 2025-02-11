require_relative 'function/game_config'
require_relative 'function/select_word'
require_relative 'function/feedback'

class Game
  def initialize
    @random_word = nil
    @min_letters = GameConfig::MIN_LETTERS
    @max_letters = GameConfig::MAX_LETTERS
    @turns_left = GameConfig::TURNS
  end

  def play
    puts "Hangman!! I'll pick a word. Try guessing it"
    @random_word = SelectWord.generate
    puts @random_word
    
    if Feedback.verify(@random_word) != 'true'
      @random_word = SelectWord.generate until Feedback.verify(@random_word) == 'true'
      puts @random_word
    end

    #Save the random word into a file using serialization
    #Use the number of letters in the random word to generate BLANKs

    #~LOOP~
    #Take the player's guess
    #Compare the letter against the random word
    #If the letter exists in the random word,
    #Find where the letter exists in the random word (multiple if needed)
    #Populate BLANKs with the letter using location of original random word
    #Save this as the new "guess" file
    #Minus one turns_left
  end

 def game_over?
    @turns_left == 0
 end
end