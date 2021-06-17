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

  private

end


class Player 
  @@number_of_players = 0

  def initialize(name)
    @name = name
    @@number_of_players += 1
    @player_id = @@number_of_players
    @player_symbol = (@player_id == 1)? "X" : "O"  
  end

  attr_reader :name, :player_id, :player_symbol

  private
end


class Game

  attr_reader :player_1, :player_2, :board, :current_player_move
  attr_accessor :current_player

  def initialize
    self.instantiate_players(get_player_1_name, get_player_2_name)
    @current_player = player_1
    
    self.instantiate_board
    
    
  end

  def play_game
    board.display_board
    
    self.get_current_player_move

    self.reprompt_input
    self.update_cells
    board.display_board
    
    binding.pry
  end
  
  private 

  def get_player_1_name
    puts "What is Player 1's name?"
    @player_1_name = gets.chomp.to_s
  end
  
  def get_player_2_name
    puts "What is Player 2's name?"
    @player_2_name = gets.chomp.to_s
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
    board.cells.include?(current_player_move)
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
  

  
  
end

Game.new.play_game

a = "a"

# game.prompt_player_1
# game.prompt_player_2
# game.instantiate_players



