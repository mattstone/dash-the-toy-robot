class Game
  
  def initialize(options = {})
    @test = true if options[:test] == true
    
    if !is_test?
      print "\n"
      print "Place 🤖 on the table and go exploring.\n"
      print "\n" 
      print "Be careful you don't fall off. You have 3 ❤️ 's\n"
      print "\n"
    
      show_usage
    end
    
    @🤖    = Robot.new(options)    
    @score = 0
    @commands_valid = false
    
    game_loop if !is_test?
  end
  
  def 🤖
    @🤖
  end
  
  #
  # Game loop
  #
  
  def game_loop

    while @🤖.is_alive?
      say "Your move"
      error  = nil
      array  = STDIN.gets.strip.split(' ') # Accept user input
      
      next if array[0].nil?
      
      error = process_move(array)
      
      case 
      when @🤖.error?
        say "Life lost" if !@🤖.full_health?
        
        case @🤖.lives > 1
        when true  then print "#{@🤖.error}\n\n".colorize(:red)
        when false
          # Flash warning of one life left!
          print "#{@🤖.error.gsub(" ❤️", "")}".colorize(:red)
          print "❤️".colorize(:red).blink
          print "\n\n"
        end
        
      when !error.nil?
        print "#{error}\n\n".colorize(:red)
        show_usage
      else 
        @score += 1 if !@quit
      end
      
    end
    
    game_over
    
  end
  
  def process_move(array)
    error = nil 
    @🤖.reset_error!
    
    case array[0].upcase
    when "PLACE"
      @commands_valid = true if !commands_valid?
      
      case array.count == 4
      when false then error = "PLACE command requires format PLACE X Y ORIENTATION"
      when true  then @🤖.place!(array[1], array[2], array[3])
      end
      
    when "MOVE"   then @🤖.move!  if commands_valid?
    when "LEFT"   then @🤖.left!  if commands_valid?
    when "RIGHT"  then @🤖.right! if commands_valid?
    when "REPORT" then @🤖.stat   if commands_valid?
    when "?"      then show_usage
    when "EXIT"   then @🤖.💀!
    else               error = "\nInvalid input: #{array.join(' ')}"
    end
    
    error
  end
  
  private 
  
  def is_test?
    @test == true
  end
  
  def commands_valid?
    @commands_valid == true 
  end
  
  def say(string)
    system("say '#{string}'") if mac?
  end
  
  def show_usage 
    print "\n"
    print "Usage\n"
    print "==================\n"
    print "PLACE X Y NORTH/SOUTH/EAST/WEST\n"
    print "MOVE\n"   # move forward on space in direction facing
    print "LEFT\n"   # changes orientation
    print "RIGHT\n"  # changes orientation 
    print "REPORT\n" # show location
    print "EXIT\n"
    print "?\n"      # show instructions
    print "\n"
  end
  
  def mac?
    (/darwin/ =~ RUBY_PLATFORM) != nil
  end
  
  def game_over
    print "\n"
    print "=====================================\n".colorize(:red).blink
    print "=             GAME OVER             =\n".colorize(:red).blink
    print "=====================================\n".colorize(:red).blink
    print "\n"
    print "Score: #{@score}\n".colorize(:cyan).blink
    print "\n"

    say "Game over"
    
    case @score 
    when 0..4 then print "Level: 🤡 Bozo\n".colorize(:cyan).blink
    when 5..9 then print "Level: 🙂 Average\n".colorize(:cyan).blink
    else           print "Level: 🤩 Legend\n".colorize(:cyan).blink
    end

    print "\n"
  end
  
end
