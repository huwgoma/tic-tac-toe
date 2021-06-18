require 'pry'
class Board
  def initialize
    @cells = Array(1..9)
  end

  attr_reader :cells
  
  def display_board
    puts <<-BOARD

       #{cells[0]} | #{cells[1]} | #{cells[2]}
      ---+---+---
       #{cells[3]} | #{cells[4]} | #{cells[5]}
      ---+---+---
       #{cells[6]} | #{cells[7]} | #{cells[8]}

    BOARD
  end

  def board_tie?
    cells.all? {|cell| cell == "X" || cell == "O"}
  end

  def has_winner?
    rows_win? ||
    columns_win? ||
    diagonals_win? 
  end
  
  def game_over?
    board_tie? || has_winner?
  end

  private
  
  WIN_CONDITIONS = {
    rows: [[0,1,2], [3,4,5], [6,7,9]],
    columns: [[0,3,6], [1,4,7], [2,5,8]],
    diagonals: [[0,4,8], [2,4,6]]
  }
  
  def rows_win?
    WIN_CONDITIONS[:rows].any? do |row|
      cell_rows = row.map {|cell_index| cells[cell_index]}
      cell_rows == ["X","X","X"] || cell_rows == ["O", "O", "O"]
    end
  end

  def columns_win?
    WIN_CONDITIONS[:columns].any? do |column|
      cell_columns = column.map {|cell_index| cells[cell_index]}
      cell_columns == ["X","X","X"] || cell_columns == ["O", "O", "O"]
    end
  end

  def diagonals_win?
    WIN_CONDITIONS[:diagonals].any? do |diagonal|
      cell_diagonal = diagonal.map {|cell_index| cells[cell_index]}
      cell_diagonal == ["X","X","X"] || cell_diagonal == ["O", "O", "O"]
    end
  end
end


class Player 
  @@number_of_players = 0

  def self.number_of_players=(value)
    @@number_of_players = value
  end

  def initialize(name)
    @name = name
    @@number_of_players += 1
    @player_id = @@number_of_players
    @player_symbol = (@player_id == 1)? "X" : "O"  
  end

  attr_reader :name, :player_id, :player_symbol

end


class Game

  attr_reader :player_1, :player_2, :board, :current_player_move
  attr_accessor :current_player

  def initialize
    self.instantiate_players(get_player_1_name, get_player_2_name)
    @current_player = player_1
    
    self.instantiate_board
    board.display_board
  end

  def play_game
    while(!board.game_over?)
      self.get_current_player_move
      self.reprompt_input

      self.update_cells
      board.display_board
      
      if(board.game_over?)
        if(board.has_winner?)
          puts self.put_winner
        elsif(board.board_tie?)
          puts self.put_tie
        end
        if(replay_game?)
          replay_game
        else
          puts "Thanks for playing!"
        end
      else
        self.switch_current_player
      end
    end
  end
  
  private 

  def get_player_1_name
    puts "What is Player 1's name?"
    @player_1_name = gets.chomp
  end
  
  def get_player_2_name
    puts "What is Player 2's name?"
    @player_2_name = gets.chomp
  end
  
  def instantiate_players(player_1_name, player_2_name)
    @player_1 = Player.new(player_1_name)
    @player_2 = Player.new(player_2_name)
  end

  def instantiate_board
    @board = Board.new
  end

  def get_current_player_move
    puts "#{current_player.name}, enter a number (1-9) corresponding to the grid cell you want to mark."
    @current_player_move = gets.to_i
  end

  def valid_number?
    current_player_move.between?(1,9) && board.cells.include?(current_player_move)
  end

  def reprompt_input
    while(!valid_number?)
      puts "Please enter a valid number!"
      self.get_current_player_move
    end
  end

  def update_cells
    target_index = board.cells.find_index(current_player_move)
    board.cells[target_index] = current_player.player_symbol
  end
  
  def switch_current_player
    self.current_player = (current_player.player_id == 1)? player_2 : player_1
    #binding.pry
  end
    
  def put_winner
    "#{current_player.name} wins!"
  end

  def put_tie
    "It's a tie!"
  end
  
  def replay_game?
    replay_answer = ''
    loop do 
      puts "Play again? (Y/N)"
      replay_answer = gets.chomp.downcase
      break if (replay_answer != "y" || replay_answer != "n")
    end
    (replay_answer == 'y')? true : false
  end

  def replay_game
    Player.number_of_players=(0)
    Game.new.play_game
  end
  
end

Game.new.play_game




