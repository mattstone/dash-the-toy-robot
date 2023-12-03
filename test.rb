class Test 
  def initialize 
    @passed = 0
    @failed = 0
    @game   = Game.new({ test: true })
    
    test_runner
  end
  
  #
  # Housekeeping
  #
  
  def good(string)
    @passed += 1
    print "  👍 #{string}\n".colorize(:green)
  end

  def bad(string)
    @failed += 1
    print "  🍄 #{string}\n".colorize(:red)
  end
  
  def header(string)
    print "\n".colorize(:cyan)
    print "#{string}\n".colorize(:cyan)
    print "=======================\n".colorize(:cyan)
  end

  def footer
    print "\n"
    print "=======================\n".colorize(:cyan)
    print "TEST COMPLETE\n".colorize(:cyan)
    print "=======================\n".colorize(:cyan)
    print "Passed #{@passed}\n".colorize(:green)
    print "Failed #{@failed}\n".colorize(:red)
    print "\n"
  end

  #
  # Test runner
  #


  def test_runner 
    print "=======================\n".colorize(:cyan)
    print "TEST RUNNER\n".colorize(:cyan)
    print "=======================\n".colorize(:cyan)
    
    place_tests
    
    left_tests
    
    right_tests
    
    move_tests

    report_tests
    
    footer
  end 
  
  #
  # Place tests
  #
  
  def place_tests
    header("place_tests")
    
    valid_orientation = "EAST"
    
    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 has x and y initialised as 0")
    when false then bad("@🤖 does not have x and y initialised as 0")
    end
    
    @game.process_move(["MOVE"])
    
    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not execute MOVE before being placed")
    when false then bad("@🤖 executes MOVE before being placed")
    end

    @game.process_move(["LEFT"])
    
    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not execute LEFT before being placed")
    when false then bad("@🤖 executes LEFT before being placed")
    end

    @game.process_move(["RIGHT"])
    
    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not execute RIGHT before being placed")
    when false then bad("@🤖 executes RIGHT before being placed")
    end
    
    error = @game.process_move(["PLACE", "DDD"])

    case !error.nil?
    when true  then good("@🤖 PLACE generates error with invalid x")
    when false then bad("@🤖 PLACE does not generate error with invalid x")
    end

    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not move with invalid PLACE x")
    when false then bad("@🤖 does not move with invalid PLACE x")
    end

    error = @game.process_move(["PLACE", "1", "ddd"])

    case !error.nil?
    when true  then good("@🤖 PLACE generates error with invalid y")
    when false then bad("@🤖 PLACE does not generate error with invalid y")
    end

    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not move with invalid PLACE y")
    when false then bad("@🤖 does not move with invalid PLACE y")
    end

    error = @game.process_move(["PLACE", "1", "1", "asdfads"])

    case !@game.🤖.error.nil?
    when true  then good("@🤖 PLACE generates error with invalid orientation")
    when false then bad("@🤖 PLACE does not generate error with invalid orientation")
    end

    case @game.🤖.position_x == 0 and @game.🤖.position_y == 0
    when true  then good("@🤖 does not move with invalid PLACE orientation")
    when false then bad("@🤖 does not move with invalid PLACE orientation")
    end

    error = @game.process_move(["PLACE", "3", "3", valid_orientation])
    
    case error.nil? and @game.🤖.error.nil?
    when true  then good("@🤖 valid PLACE generates no error")
    when false then bad("@🤖 valid PLACE does not generate error")
    end

    case @game.🤖.position_x == 3 and @game.🤖.position_y == 3
    when true  then good("@🤖 valid PLACE changes x")
    when false then bad("@🤖 valid PLACE does not change x")
    end

    case @game.🤖.orientation_to_s.upcase == valid_orientation
    when true  then good("@🤖 valid PLACE orientation is #{valid_orientation}")
    when false then bad("@🤖 valid PLACE orientation is not #{valid_orientation}")
    end
  end
  
  #
  # Left tests
  #

  def left_tests
    header("left_tests")
    
    valid_orientation = "EAST"
    move              = "LEFT"
    
    case @game.🤖.orientation_to_s.upcase == valid_orientation
    when true  then good("@🤖 valid PLACE orientation is #{valid_orientation}")
    when false then bad("@🤖 valid PLACE orientation is not #{valid_orientation}")
    end
    
    error = @game.process_move([move])
    
    case @game.🤖.orientation_to_s.upcase == "NORTH"
    when true  then good("@🤖 EAST turned #{move} is NORTH")
    when false then bad("@🤖 EAST turned #{move} is NORTH")
    end

    error = @game.process_move([move])
    
    case @game.🤖.orientation_to_s.upcase == "WEST"
    when true  then good("@🤖 NORTH turned #{move} is WEST")
    when false then bad("@🤖 NORTH turned #{move} is WEST")
    end

    error = @game.process_move([move])
    
    case @game.🤖.orientation_to_s.upcase == "SOUTH"
    when true  then good("@🤖 WEST turned #{move} is SOUTH")
    when false then bad("@🤖 WEST turned #{move} is SOUTH")
    end

    error = @game.process_move([move])
    
    case @game.🤖.orientation_to_s.upcase == "EAST"
    when true  then good("@🤖 SOUTH turned #{move} is EAST")
    when false then bad("@🤖 SOUTH turned #{move} is EAST")
    end
    
  end
  
  #
  # Right tests
  #
  
  def right_tests
    header("right_tests")
    
    move = "RIGHT"

    case @game.🤖.orientation_to_s.upcase == "EAST"
    when true  then good("@🤖 orientation should be EAST")
    when false then bad("@🤖 orientation is not EAST")
    end
    
    error = @game.process_move([move])

    case @game.🤖.orientation_to_s.upcase == "SOUTH"
    when true  then good("@🤖 EAST turned #{move} is SOUTH")
    when false then bad("@🤖 EAST turned #{move} is not SOUTH")
    end

    error = @game.process_move([move])

    case @game.🤖.orientation_to_s.upcase == "WEST"
    when true  then good("@🤖 SOUTH turned #{move} is WEST")
    when false then bad("@🤖 SOUTH turned #{move} is not WEST")
    end

    error = @game.process_move([move])

    case @game.🤖.orientation_to_s.upcase == "NORTH"
    when true  then good("@🤖 WEST turned #{move} is NORTH")
    when false then bad("@🤖 WEST turned #{move} is not NORTH")
    end

    error = @game.process_move([move])

    case @game.🤖.orientation_to_s.upcase == "EAST"
    when true  then good("@🤖 NORTH turned #{move} is EAST")
    when false then bad("@🤖 NORTH turned #{move} is not EAST")
    end

  end
  
  #
  # Move tests
  #
  
  def move_tests
    header("move_tests")
    
    start_x = 3
    start_y = 3
    
    move    = "MOVE"
    
    case @game.🤖.position_x == start_x and @game.🤖.position_y == start_y
    when true  then good("@🤖 has x of #{start_x} and y of #{start_y}")
    when false then bad("@🤖 does not have x of #{start_x} and y of #{start_y}")
    end

    case @game.🤖.orientation_to_s.upcase == "EAST"
    when true  then good("@🤖 orientation is EAST")
    when false then bad("@🤖 orientation is not EAST")
    end

    error = @game.process_move([move])

    case error.nil? and @game.🤖.error.nil?
    when true  then good("@🤖 MOVE generates no errors")
    when false then bad("@🤖 MOVE generates no errors")
    end

    new_x = start_x + 1
    case @game.🤖.position_x == new_x and @game.🤖.position_y == start_y
    when true  then good("@🤖 has x of #{new_x} and y of #{start_y}")
    when false then bad("@🤖 does not have x of #{new_x} and y of #{start_y}")
    end

    error = @game.process_move([move])

    case error.nil? and !@game.🤖.error.nil?
    when true  then good("@🤖 invalid MOVE generated error")
    when false then bad("@🤖 invalid MOVE did not generate error")
    end

    case @game.🤖.lives == 2
    when true  then good("@🤖 invalid MOVE lost a Life")
    when false then bad("@🤖 invalid MOVE did not lose a life")
    end

    start_x = 2
    start_y = 3
    error = @game.process_move(["place", "#{start_x}", "#{start_y}", "north"])

    case error.nil? and @game.🤖.error.nil?
    when true  then good("@🤖 valid PLACE has no errors")
    when false then bad("@🤖 valid PLACE has errors")
    end

    case @game.🤖.lives == 3
    when true  then good("@🤖 valid PLACE resets Lives")
    when false then bad("@🤖 valid PLACE does not reset Lives")
    end

    case @game.🤖.position_x == start_x and @game.🤖.position_y == start_y
    when true  then good("@🤖 valid PLACE positions x correctly")
    when false then bad("@🤖 valid PLACE positions y correctly")
    end

    error = @game.process_move(["move"])

    new_y = start_y + 1
    case @game.🤖.position_x == start_x and @game.🤖.position_y == new_y
    when true  then good("@🤖 valid MOVE positions x and y correctly")
    when false then bad("@🤖 valid MOVE positions x and y correctly")
    end

    error = @game.process_move(["move"])

    case error.nil? and !@game.🤖.error.nil?
    when true  then good("@🤖 invalid MOVE generated error")
    when false then bad("@🤖 invalid MOVE did not generate error")
    end

    case @game.🤖.lives == 2
    when true  then good("@🤖 invalid MOVE lost a Life")
    when false then bad("@🤖 invalid MOVE did not lose a life")
    end

    error = @game.process_move(["move"])

    case error.nil? and !@game.🤖.error.nil?
    when true  then good("@🤖 invalid MOVE generated error")
    when false then bad("@🤖 invalid MOVE did not generate error")
    end

    case @game.🤖.lives == 1
    when true  then good("@🤖 invalid MOVE lost a Life")
    when false then bad("@🤖 invalid MOVE did not lose a life")
    end

    error = @game.process_move(["move"])

    case error.nil? and !@game.🤖.error.nil?
    when true  then good("@🤖 invalid MOVE generated error")
    when false then bad("@🤖 invalid MOVE did not generate error")
    end
    
    case @game.🤖.lives == 0
    when true  then good("@🤖 invalid MOVE lost a Life")
    when false then bad("@🤖 invalid MOVE did not lose a life")
    end

    error = @game.process_move(["place", "#{start_x}", "#{start_y}", "north"])

    case error.nil? and @game.🤖.error.nil?
    when true  then good("@🤖 valid PLACE has no errors")
    when false then bad("@🤖 valid PLACE has errors")
    end

    case @game.🤖.lives == 3
    when true  then good("@🤖 valid PLACE resets Lives")
    when false then bad("@🤖 valid PLACE does not reset Lives")
    end
    
    error = @game.process_move(["left"])

    case @game.🤖.orientation_to_s.upcase == "WEST"
    when true  then good("@🤖 valid LEFT changes orientation to WEST")
    when false then bad("@🤖 valid LEFT does not change orientation to WEST")
    end

    error = @game.process_move(["move"])

    new_x = start_x - 1
    
    case @game.🤖.position_x == new_x and @game.🤖.position_y == start_y
    when true  then good("@🤖 valid MOVE positions x and y correctly")
    when false then bad("@🤖 valid MOVE positions x and y correctly")
    end

    error = @game.process_move(["left"])

    case @game.🤖.position_x == new_x and @game.🤖.position_y == start_y
    when true  then good("@🤖 valid MOVE positions x and y correctly")
    when false then bad("@🤖 valid MOVE positions x and y correctly")
    end

    case @game.🤖.orientation_to_s.upcase == "SOUTH"
    when true  then good("@🤖 valid LEFT changes orientation to SOUTH")
    when false then bad("@🤖 valid LEFT does not change orientation to SOUTH")
    end

    error = @game.process_move(["move"])
    new_y = start_y - 1
    
    case @game.🤖.position_x == new_x and @game.🤖.position_y == new_y
    when true  then good("@🤖 valid MOVE positions x and y correctly")
    when false then bad("@🤖 valid MOVE positions x and y correctly")
    end

  end
  
  #
  # Report tests
  #
  
  def report_tests
    @game.🤖.stat
  end
  
end
