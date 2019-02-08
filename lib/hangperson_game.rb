class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
 
 # takes a parameter and returns a HangpersonGame object
  attr_accessor :word, :guesses, :wrong_guesses
   
  def initialize(word)
    
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end


  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  #changes correct guess list
  def guess(a)
    
    #throws an error when empty
    #throws an error when nil
    if (a=='' || a== NIL) #check if an empty word is entered if so disallow it
      raise ArgumentError, "No word entered" #http://rubylearning.com/satishtalim/ruby_exceptions.html
    end #end if
    
    #throws an error when not a letter
    if (a.match(/[^A-Za-z]/)) # check if the user has entered a number, if so disallow it. 
      raise ArgumentError, "No numbers, only letters"
    end #end if
    
    #is case insensitive
    a=a.downcase() #change all the letters to lowercase
    
    lists=@word.split("") #split words 
    lists.each do |list| # go over the list
      if(a==list) # the guess is in the list
        @wrong_guesses+=""
        if(!guesses.include?a) 
          @guesses+=a
          return true 
        end #end inner if
        return false
      end #end of list check
    end #end list.each
    
    #changes wrong guess list
    @guesses+= ''
    if(!@wrong_guesses.include?a)
      @wrong_guesses+=a
      return true #returns true
    end #end if
    return false
  end #end guessing
  
  def word_with_guesses
    current= ''
    var= 0
    ges=@guesses.split("")
    temps=@word.split("")
    temps.each do |temp|
      ges.each do |a|
        if(temp == a)
          current += a
          var = 1
        end
      end
      if (var == 0)
        current += '-'
      end
      var = 0
    end
    #puts "test : " + current #check output in console
    #should be '------' when guesses are 'def'
    #should be 'banana' when guesses are 'ban'
    return current
  end #end word_with_guesses
  
  def check_win_or_lose
    count = 0
    temps = @word.split("")
    comps = @guesses.split("")
    temps.each do |temp|
      comps.each do|comp|
      if(comp==temp)
        count += 1
        break
      end #end if
    end #end loop
  end #end check_win_or_lose
  if (@wrong_guesses.length == 7)
    :lose
  elsif (temps.length == count)
    :win
  else
    :play
  end
  end

  
  
  
end #end game
