# Game-handling class
class Game
  include GameMessages

  attr_reader :player_one, :player_two, :board, :current_player_move
  attr_accessor :current_player

  def initialize
    @player_one = Player.new(get_player_one_name)
    @player_two = Player.new(get_player_two_name)
    @current_player = @player_one
    @board = Board.new
    
  end

  def play
    board.display_board
    until game_over?
      binding.pry
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
    board.win_conditions_met?
    #board.win_conditions_met? || board.full?
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