require_relative 'function/select_word'
require_relative 'function/feedback'
require_relative 'function/player_input'
require 'json'

class Game
  attr_accessor @word, :guesses, :turns_remaining, :guessed_letters
  def initialize
    @word = nil
    @guessed_letters = []
    @guesses = 0
    @turns_remaining = #letter length - guesses
  end

  def save_game
    game_state = {
    @word: @word,
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

    @word = game_state['word']
    @guesses = game_state['guesses']
    @turns_remaining = game_state['turns_remaining']

    puts "Game loaded!"
  end

  def play
    puts "Hangman!! I'll pick a word. Try guessing it"
    @word = SelectWord.generate
    
    if Feedback.verify(@word) != 'true'
      @word = SelectWord.generate until Feedback.verify(@word) == 'true'
      puts @word
    end

    File.open('hangman_word.txt', 'w') do |file|
      file.puts(@word)
    end

    word = File.read('hangman_word.txt').chomp
    puts word

    loop do
      #Display progress. Use the number of letters in the random word to generate BLANKs
      puts "Guess a letter."
      guess = PlayerInput.get

      #Compare the letter against the random word
      #If the letter exists in the random word,
      #Find where the letter exists in the random word (multiple if needed)
      #Populate BLANKs with the letter using location of original random word
      #Save this as the new "guess" file
      #Minus one turns_left
    end
  end

 def game_over?
    @turns_remaining == 0 || 
 end
end