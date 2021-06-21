# frozen_string_literal: true

require 'pry'

# Tic Tac Toe Board Class
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

  def full?
    board_full?
  end

  def winner_exists?
    board_has_winner?
  end

  def check_game_over?
    game_over?
  end
  
  private

  def board_full?
    cells.all? { |cell| cell == 'X' || cell == 'O' }
  end

  def board_has_winner?
    rows_win? ||
      columns_win? ||
      diagonals_win?
  end

  def game_over?
    board_full? || winner_exists?
  end

  WIN_CONDITIONS = {
    rows: [[0, 1, 2], [3, 4, 5], [6, 7, 8]],
    columns: [[0, 3, 6], [1, 4, 7], [2, 5, 8]],
    diagonals: [[0, 4, 8], [2, 4, 6]]
  }.freeze
  
  def rows_win?
    cell_rows = WIN_CONDITIONS[:rows].map do |row|
      row.map { |cell_index| cells[cell_index] }
    end
    cell_rows.include?(%w[X X X]) || cell_rows.include?(%w[O O O])
  end

  def columns_win?
    cell_columns = WIN_CONDITIONS[:columns].map do |column|
      column.map { |cell_index| cells[cell_index] }
    end
    cell_columns.include?(%w[X X X]) || cell_columns.include?(%w[O O O])
  end

  def diagonals_win?
    cell_diagonal = WIN_CONDITIONS[:diagonals].map do |diagonal|
      diagonal.map { |cell_index| cells[cell_index] }
    end
    cell_diagonal.include?(%w[X X X]) || cell_diagonal.include?(%w[O O O])
  end
end

# Player Class
class Player
  @@number_of_players = 0

  def self.number_of_players=(value)
    @@number_of_players = value
  end

  def initialize(name)
    @name = name
    @@number_of_players += 1
    @player_id = @@number_of_players
    @player_symbol = @player_id == 1 ? 'X' : 'O'
  end

  attr_reader :name, :player_id, :player_symbol
end

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

# Game-handling class
class Game
  include GameMessages

  attr_reader :player_one, :player_two, :board, :current_player_move
  attr_accessor :current_player

  def initialize
    instantiate_players(get_player_one_name, get_player_two_name)
    @current_player = player_one
    
    instantiate_board
    board.display_board
    play_game
  end

  def play_game
    until board.check_game_over?
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
  
  private

  def instantiate_players(player_one_name, player_two_name)
    @player_one = Player.new(player_one_name)
    @player_two = Player.new(player_two_name)
  end

  def instantiate_board
    @board = Board.new
  end

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

Game.new
