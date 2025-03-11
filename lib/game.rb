require_relative 'function/game_config'
require_relative 'function/select_word'
require_relative 'function/feedback'
require 'json'

class Game
  attr_accessor :random_word, :guesses, :turns_remaining
  def initialize
    @random_word = nil
    @guesses = 0
    @turns_remaining = #letter length - guesses
    @min_letters = GameConfig::MIN_LETTERS
    @max_letters = GameConfig::MAX_LETTERS
  end

  def save_game
    game_state = {
      random_word: @random_word,
      guesses: @guesses,
      turns_remaining: @turns_remaining
    }

    File.open('game_save.json', 'w') { |file| file.puts JSON.dump(game_state)}
     puts "Game saved!"
  end

  def load_game
    return unless File.exist?('game_save.json')

    json_data = File.read('game_save.json')
    game_state = JSON.parse(json_data)

    @random_word = game_state['word']
    @guesses = game_state['guesses']
    @turns_remaining = game_state['turns_remaining']

    puts "Game loaded!"
  end

  def play
    puts "Hangman!! I'll pick a word. Try guessing it"
    @random_word = SelectWord.generate
    
    if Feedback.verify(@random_word) != 'true'
      @random_word = SelectWord.generate until Feedback.verify(@random_word) == 'true'
      puts @random_word
    end

    File.open('hangman_word.txt', 'w') do |file|
      file.puts(@random_word)
    end

    word = File.read('hangman_word.txt').chomp
    puts word

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
    @turns_remaining == 0
 end
end