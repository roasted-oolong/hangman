require_relative 'lib/game_config.rb'
require_relative 'lib/select_word.rb'

class Game
  def initialize
    @random_word = nil
    @min_letters = GameConfig::MIN_LETTERS
    @max_letters = GameConfig::MAX_LETTERS
  end

  def play
    puts "Hangman!! n/ I'll pick a word. n/ Try guessing it"
end