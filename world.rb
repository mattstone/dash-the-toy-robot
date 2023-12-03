class World 

  def initialize
    @min_x = 0
    @min_y = 0
    @max_x = 5
    @max_y = 5
  end 
  
  def position_valid?(x, y)
    return false if !x.between?(@min_x, (@max_x - 1))
    return false if !y.between?(@min_y, (@max_y - 1))    
    true
  end
  
  def horizonal_line 
    1.upto((2 * @max_y) + 6) { |i| print "-" }
    new_line
  end
  
  def new_line
    print "\n"
  end
  
  def divider_char 
    print "|"
  end
  
  def show_map(robot_x, robot_y, orientation, sprite)
    
    horizonal_line

    (@max_y - 1).downto(0) do |y|
      0.upto(@max_x - 1) do |x|
        divider_char
        print case robot_x == x and robot_y == y 
              when true  then sprite 
              when false then "🌑"
              end
      end
      
      divider_char
      new_line
      horizonal_line
    end
    
    new_line
  end
  
end
