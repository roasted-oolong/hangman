module SelectWord
  def self.generate
    words = File.readlines('google-1000-english-no-swears.txt')
    random_word = words.sample
    random_word
  end
end