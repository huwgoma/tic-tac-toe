# Tic Tac Toe Board Class
class Board
  attr_reader :cells

  def initialize
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

  WIN_CONDITIONS = {
    rows: [[0, 1, 2], [3, 4, 5], [6, 7, 8]],
    columns: [[0, 3, 6], [1, 4, 7], [2, 5, 8]],
    diagonals: [[0, 4, 8], [2, 4, 6]]
  }.freeze

  def win_conditions_met?
    [rows_win?, columns_win?, diagonals_win?].include?(true) 
  end

  def full?
    cells.all? { |cell| cell == 'X' || cell == 'O' }
  end
  
  def rows_win?
    cell_rows = WIN_CONDITIONS[:rows].map do |row|
      row.map { |index| cells[index] }
    end
    cell_rows.include?(%w[X X X]) || cell_rows.include?(%w[O O O])
  end

  def columns_win?
    cell_columns = WIN_CONDITIONS[:columns].map do |column|
      column.map { |index| cells[index] }
    end
    cell_columns.include?(%w[X X X]) || cell_columns.include?(%w[O O O])
  end

  def diagonals_win?
    cell_diagonal = WIN_CONDITIONS[:diagonals].map do |diagonal|
      diagonal.map { |index| cells[index] }
    end
    cell_diagonal.include?(%w[X X X]) || cell_diagonal.include?(%w[O O O])
  end

  def update_cells(number, symbol)
    index = number - 1
    @cells[index] = symbol
  end
end