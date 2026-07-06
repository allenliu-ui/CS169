class WordGuesserGame
  # add the necessary class methods, attributes, etc. here
  attr_accessor :word, :guesses,:wrong_guesses
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  def initialize(word)
    @word          = word
    @guesses       = ''
    @wrong_guesses = ''
  end


  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('https://randomword.saasbook.info/RandomWord')
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.get(uri.path)
      return response.body.scan(/<div>(.+?)<\/div>/).flatten.first
    end
  end

  def guess(letter)
    raise ArgumentError if letter.nil? || letter.empty? || letter !~ /[a-zA-Z]/
    letter = letter.downcase
    if @guesses.include?(letter) || @wrong_guesses.include?(letter)
      return false
    end
    if @word.include?(letter)
      @guesses += letter
    else
      @wrong_guesses += letter
    end
    true
  end

  def word_with_guesses
    displayed_word = ''
    @word.each_char do |char|
      if @guesses.include?(char)
        displayed_word += char  
      else
        displayed_word += '-'   
      end
    end
    displayed_word
  end

  def check_win_or_lose
    if @wrong_guesses.length >= 7
      :lose
    elsif !word_with_guesses.include?('-')
      :win
    else
      :play
    end
  end

end
