class Robot 
  attr_accessor :orientation, :position_x, :position_y, :error, :lives
  
  ORIENTATION = {
    NORTH: 1,
    WEST:  2,
    SOUTH: 3,
    EAST:  4
  }
  
  def initialize(options = {})
    @test        = true if options[:test] == true
    
    @orientation = ORIENTATION[:NORTH]
    @position_x  = 0
    @position_y  = 0
    @world       = World.new
    @max_lives   = 3

    reset_error!
    reset_health!
  end
  
  def reset_error!
    @error = nil
  end
  
  def error?
    !@error.nil?
  end
  
  def is_test?
    @test == true
  end
  
  def orientation_to_s
    string = ORIENTATION.key(@orientation).to_s
    string.nil? ? "Unknown" : string.capitalize
  end
  
  def stat 
    case is_test?
    when true  then { x: @position_x, y: @position_y, orientation: orientation_to_s }
    when false then print "🤖 is at position x: #{@position_x} y: #{@position_y} and is facing #{orientation_to_s}. #{lives_left_to_s}\n\n".colorize(:cyan)
    end
    
  end
  
  def place!(x, y, orientation)
    case is_number?(x)
    when false then @error = "X coordinate is not an integer"
    when true  then @error = "Y coordinate is not an integer" if !is_number?(y)
    end
    
    @error += ". #{lives_left_to_s}" if !@error.nil?

    if !error?
      x = x.to_i 
      y = y.to_i

      case @world.position_valid?(x, y)
      when false then @error = "This position is invalid."
      when true 
        orientation = orientation.to_s.upcase.to_sym 
        
        case ORIENTATION.has_key?(orientation)
        when false then @error = "#{orientation} is an invalid orientation. Must be one of NORTH SOUTH EAST WEST"
        when true 
          @orientation = ORIENTATION[orientation]
          @position_x  = x 
          @position_y  = y
          reset_health!
          show_map
        end
      end
      
      @error += " #{lives_left_to_s}" if error?
    end
  end
  
  def move!()
    save_position!
    
    case @orientation 
    when ORIENTATION[:NORTH] then @position_y += 1
    when ORIENTATION[:WEST]  then @position_x -= 1
    when ORIENTATION[:SOUTH] then @position_y -= 1
    when ORIENTATION[:EAST]  then @position_x += 1
    end
    
    if !@world.position_valid?(@position_x, @position_y)
      lose_life!
      
      @error = case is_alive?
        when true  then "You made #{sprite} fall off the table! #{lives_left_to_s}"
        when false then ""
        end
      
      restore_position!
    end
    
    show_map
  end
  
  def full_health?
    @max_lives == @lives
  end 
  
  def reset_health!
    @lives = @max_lives
  end

  def lose_life!
    @lives = [0, @lives - 1].max
  end
  
  def is_alive?
    @lives > 0
  end
  
  def lives_left
    return sprite if @lives == 0 
    (1..@lives).inject("") { |string, i| string += "❤️ "}
  end
  
  def lives_left_to_s 
    "Lives: #{lives_left}"
  end
  
  def sprite 
    is_alive? ? "🤖" : "💀"
  end
  
  def left!
    @orientation += 1
    @orientation  = ORIENTATION[:NORTH] if @orientation > ORIENTATION[:EAST]
    show_map
  end

  def right!
    @orientation -= 1
    @orientation  = ORIENTATION[:EAST] if @orientation < ORIENTATION[:NORTH]
    show_map
  end
  
  def show_map
    return if is_test? # don't show map in test mode
    
    @world.show_map(@position_x, @position_y, orientation_to_s, sprite)
    stat
  end
    
  private 
  
  def is_number?(string)
    return false if string.empty?
    string.scan(/\D/).empty?
  end
  
  def save_position!
    @old_position_x = @position_x 
    @old_position_y = @position_y
  end
  
  def restore_position!
    @position_x = @old_position_x
    @position_y = @old_position_y
  end
  
end
