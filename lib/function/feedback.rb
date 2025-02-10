require_relative 'game_config'

module Feedback
  def self.verify(word)
    if word.length < GameConfig::MIN_LETTERS || word.length > GameConfig::MAX_LETTERS
      return 'false'
    else
      return 'true'
    end
  end
end