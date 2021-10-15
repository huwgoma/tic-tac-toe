# Game-handling class
class Game
  include GameMessages

  attr_reader :player_one, :player_two, :board, :player_move
  attr_accessor :current_player

  def initialize(board = Board.new)
    @player_one = create_player(1)
    @player_two = create_player(2)
    @current_player = @player_one
    @board = board
  end

  def play
    board.display_board
    # until game_over?
    #   get_player_move
    #   reprompt_input
    #   update_cells
    #   board.display_board
      
    #   if game_over?
    #     if board.win_conditions_met?
    #       puts winner_message
    #     elsif board.full?
    #       puts tie_message
    #     end
    #     if replay_game?
    #       replay_game
    #     else
    #       puts 'Thanks for playing!'
    #     end
    #   else
    #     switch_current_player
    #   end
    # end
  end
  
  def game_loop 
    input = player_input
    board.update_cells(input, current_player.symbol)
    # Ask Board to update cells - #player_input returns the player's number (eg. 6)
    # Find the index of the given number (eg. 6 on the tic tac toe board corresponds
    # to @cells[index 5]
    # Update the target cell (cell at index 5) to the current player's symbol
  end

  def player_input
    prompt_move_input
    loop do
      user_input = gets.chomp.to_i
      verified_input = verify_input(user_input)
      return verified_input if verified_input
      puts 'Please enter a valid number!' 
    end
  end 

  def verify_input(number)
    return number if board.cells.include?(number)
  end

  def game_over?
    board.win_conditions_met? || board.full?
  end

  def create_player(player_number)
    puts "What is Player #{player_number}'s name?"
    name = gets.chomp
    Player.new(name, player_number)
  end

  private

  # def update_cells
  #   target_index = board.cells.find_index(player_move)
  #   board.cells[target_index] = current_player.symbol
  # end
  
  def switch_current_player
    self.current_player = current_player.player_id == 1 ? player_two : player_one
  end

  def replay_game
    Game.new.play
  end
end