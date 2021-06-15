class Board

  private
  attr_reader :cells
  def initialize(number)
    @cells = Array(1..9)
  end

  def display_board
    puts <<-BOARD
      #{cells[0]} | #{cells[1]} | #{cells[2]}
      ---+---+---
      #{cells[3]} | #{cells[4]} | #{cells[5]}
      ---+---+---
      #{cells[6]} | #{cells[7]} | #{cells[8]}
    BOARD
  end
end


class Player 
  @@number_of_players = 0

  private
  def initialize(name)
    @name = name
    @@number_of_players += 1
    @player_id = @@number_of_players
    @player_symbol = (@player_id == 1)? "X" : "O"  
  end
end


class Game
  
  def prompt_player_1
    puts "What is Player 1's name?"
    @player_1_name = gets.chomp.to_s
  end
  
  def prompt_player_2
    puts "What is Player 2's name?"
    @player_2_name = gets.chomp.to_s
  end
  
  def instantiate_players
    Player.new(@player_1_name)
    Player.new(@player_2_name)
  end
end

game = Game.new
game.prompt_player_1
game.prompt_player_2
game.instantiate_players



