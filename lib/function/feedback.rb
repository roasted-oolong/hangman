require_relative 'game_config'

module Feedback
  def self.verify(word)
    if word.length < GameConfig::MIN_LETTERS || word.length > GameConfig::MAX_LETTERS
      return 'false'
    else
      return 'true'
    end
  end

  def self.correct_guess?(letter, word)
    word.downcase.include? letter
  end

  def self.display_progress(guessed_word_array, word = "")
    case guessed_word_array.empty?
    when true
      guessed_word_array = Array.new(word.length, "_")
      return guessed_word_array
    when false
      guessed_word_array.join(" ")
    end
  end
end