# Module for storing game message methods
module GameMessages
  private 

  def get_player_one_name
    puts "What is Player 1's name?"
    @player_one_name = gets.chomp
  end

  def get_player_two_name
    puts "What is Player 2's name?"
    @player_two_name = gets.chomp
  end

  def get_current_player_move
    puts "#{current_player.name}, enter a number (1-9) corresponding to the grid cell you want to mark."
    @current_player_move = gets.to_i
  end
  
  def reprompt_input
    until valid_number?
      puts 'Please enter a valid number!'
      get_current_player_move
    end
  end

  def tie_message
    "It's a tie!"
  end
  
  def winner_message
    "#{current_player.name} wins!"
  end

  def replay_game?
    replay_answer = ''
    loop do
      puts 'Play again? (Y/N)'
      replay_answer = gets.chomp.downcase
      break if replay_answer != 'y' || replay_answer != 'n'
    end
    replay_answer == 'y'
  end  
end