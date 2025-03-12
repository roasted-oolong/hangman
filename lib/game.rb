require_relative 'function/select_word'
require_relative 'function/feedback'
require_relative 'function/player_input'
require 'json'

class Game
  attr_accessor :word, :incorrect_guesses, :turns_remaining, :guessed_word
  def initialize
    @word = nil
    @guessed_word = []
    @incorrect_guesses = 0
    @turns_remaining = nil #letter length - incorrect_guesses
  end

  def play
    case File.exist?('save_files/game_save.json')
    when true
      load_game
      puts "Welcome back. Let's pick up where we left off"
    when false
      puts "Hangman!! I'll pick a word. Try guessing it"
      @word = SelectWord.generate
      if Feedback.verify(@word) != 'true'
        @word = SelectWord.generate until Feedback.verify(@word) == 'true'
      end
      @turns_remaining = @word.length

      save_game
    end

    until game_over?
      puts "Your Progress: #{Feedback.display_progress(@guessed_word)}"
      puts "Guess a letter."
      letter = PlayerInput.get
  

      case Feedback.correct_guess?(letter, @word)
      when true
        guessed_word_array = Feedback.fill_in_guess(letter, @word, @guessed_word)
        #Find where the letter exists in the random word (multiple if needed)
        #Populate BLANKs with the letter using location of original random word
        #Save this as the new "guess" file
      when false
        puts "Nope. Try again."
        @incorrect_guesses += 1
        puts "#{@incorrect_guesses}"
        @turns_remaining = @word.length - @incorrect_guesses
      end

      save_game
    end

    File.delete('save_files/game_save.json')
    puts "Game Over"
    puts "The word was #{@word}"
  end

 def game_over?
    @turns_remaining <= 0 || @word == @guessed_word.join
 end

   def save_game
    game_state = {
      word: @word,
      guessed_word: @guessed_word,
      incorrect_guesses: @incorrect_guesses,
      turns_remaining: @turns_remaining
    }

    File.open('save_files/game_save.json', 'w') { |file| file.puts JSON.dump(game_state)}
     puts "Game saved!"
  end

  def load_game
    return unless File.exist?('save_files/game_save.json')

    json_data = File.read('save_files/game_save.json')
    game_state = JSON.parse(json_data)

    @word = game_state['word']
    @guessed_word = game_state['guessed_word']
    @incorrect_guesses = game_state['incorrect_guesses']
    @turns_remaining = game_state['turns_remaining']

    puts "Game loaded!"
  end
end