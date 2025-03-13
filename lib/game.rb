require_relative 'function/select_word'
require_relative 'function/feedback'
require_relative 'function/player_input'
require 'json'

class Game
  attr_accessor :word, :incorrect_guesses, :turns_remaining, :guessed_word
  def initialize
    @word = nil
    @guessed_word = nil
    @incorrect_guesses = 0
    @turns_remaining = nil #letter length - incorrect_guesses
  end

  def play
    case File.exist?('save_files/game_save.json')
    when true
      load_game
      puts "Welcome back. Let's pick up where we left off"
    when false
      puts "［ Welcome to Hangman ］ \n ※ This game will be auto-saved."
      @word = SelectWord.generate
      if Feedback.verify(@word) != 'true'
        @word = SelectWord.generate until Feedback.verify(@word) == 'true'
      end
      @turns_remaining = @word.length
      @guessed_word = Array.new(@word.length, "_")

      save_game

      puts ". \n. \n."
      puts "I've picked a word for our game 😊"
    end

    until game_over?
      puts "Your Progress: #{Feedback.display_progress(@guessed_word)}"
      puts "Guess a letter."
      letter = PlayerInput.get
      puts ". \n. \n."

      case Feedback.correct_guess?(letter, @word)
      when true
        @guessed_word = Feedback.fill_in_guess(letter, @word, @guessed_word)
      when false
        @incorrect_guesses += 1
        @turns_remaining = @word.length - @incorrect_guesses

         puts "Nope. You have #{turns_remaining} guesses left."
      end

      save_game
    end

    File.delete('save_files/game_save.json')
    case win_or_lose
    when "win"
      puts "You guessed it! [ #{@word} ]"
    when "lose"
      puts "Game Over! The word was [ #{word} ]"
    end
  end

  def game_over?
    @turns_remaining <= 0 || @word == @guessed_word.join
  end

  def win_or_lose
   if @word == guessed_word.join
    return "win"
   end
   if @turns_remaining <= 0
    return "lose"
   end
  end

  def save_game
    game_state = {
      word: @word,
      guessed_word: @guessed_word,
      incorrect_guesses: @incorrect_guesses,
      turns_remaining: @turns_remaining
    }

    File.open('save_files/game_save.json', 'w') { |file| file.puts JSON.dump(game_state)}
  end

  def load_game
    return unless File.exist?('save_files/game_save.json')

    json_data = File.read('save_files/game_save.json')
    game_state = JSON.parse(json_data)

    @word = game_state['word']
    @guessed_word = game_state['guessed_word']
    @incorrect_guesses = game_state['incorrect_guesses']
    @turns_remaining = game_state['turns_remaining']
  end
end