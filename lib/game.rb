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
    game_loop until game_over?
    game_end
    replay
  end
  
  def game_loop 
    input = player_input
    board.update_cells(input, current_player.symbol)
    board.display_board
    switch_current_player unless game_over?
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
  
  def switch_current_player
    @current_player = current_player.id == 1 ? player_two : player_one
  end

  def game_end
    puts board.win_conditions_met? ? winner_message : tie_message
  end

  def replay
    puts "Play again? (Y/N)"
    input = gets.chomp.downcase
    input == 'y' ? Game.new.play : puts('Thanks for playing!')
  end
end