require_relative 'game_config'

module Feedback(word)
  def self.verify
    if word.length < GameConfig::MIN_LETTERS || word.length > GameConfig::MAX_LETTERS
      false
    else
      true
    end
  end
end