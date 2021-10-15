# Module for storing game message methods
module GameMessages
  def prompt_move_input
    puts "#{current_player.name}, enter a number (1-9) corresponding to the grid cell you want to mark."
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