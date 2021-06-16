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

  attr_reader :player_1, :player_2
  attr_accessor :current_player

  def initialize
    self.instantiate_players(get_player_1_name, get_player_2_name)
    @current_player = player_1
    @board = Board.new
    @board.display_board
    self.prompt_current_player_move
    
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

  def prompt_current_player_move
    puts "#{current_player.name}, enter a number (1-9) corresponding to the grid cell you want to mark."
  end


  
  
end

Game.new

a = "a"

# game.prompt_player_1
# game.prompt_player_2
# game.instantiate_players



