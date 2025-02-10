require_relative 'function/game_config'
require_relative 'function/select_word'

class Game
  def initialize
    @random_word = nil
    @min_letters = GameConfig::MIN_LETTERS
    @max_letters = GameConfig::MAX_LETTERS
  end

  def play
    puts "Hangman!! I'll pick a word. Try guessing it"
    @random_word = SelectWord.generate
  end

# def game.over?
    #placeholder
 #end
end