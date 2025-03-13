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

  def self.display_progress(guessed_word_array)
      guessed_word_array.join(" ")
  end

  def self.fill_in_guess(letter, word, guessed_word_array)
    word.chars.each_with_index do |char, index|
      guessed_word_array[index] = letter if char == letter
    end
    
    guessed_word_array
  end
end