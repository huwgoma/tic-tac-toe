# Game-handling class
class Game
  include GameMessages

  attr_reader :player_one, :player_two, :board, :current_player_move
  attr_accessor :current_player

  def initialize(board = Board.new)
    @player_one = create_player(1)
    @player_two = create_player(2)
    @current_player = @player_one
    @board = board
  end

  def play
    board.display_board
    until board.check_game_over?
      #binding.pry
      get_current_player_move
      reprompt_input
      update_cells
      board.display_board
      
      if board.check_game_over?
        if board.winner_exists?
          puts winner_message
        elsif board.full?
          puts tie_message
        end
        if replay_game?
          replay_game
        else
          puts 'Thanks for playing!'
        end
      else
        switch_current_player
      end
    end
  end
  
  def game_over?
    @board.win_conditions_met?
    #board.win_conditions_met? || board.full?
  end

  def create_player(player_number)
    puts "What is Player #{player_number}'s name?"
    name = gets.chomp
    Player.new(name, player_number)
  end

  private

  def valid_number?
    current_player_move.between?(1, 9) && board.cells.include?(current_player_move)
  end

  def update_cells
    target_index = board.cells.find_index(current_player_move)
    board.cells[target_index] = current_player.player_symbol
  end
  
  def switch_current_player
    self.current_player = current_player.player_id == 1 ? player_two : player_one
  end

  def replay_game
    Player.number_of_players = (0)
    Game.new.play_game
  end
end