require_relative '../lib/game_messages'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require 'pry'

describe Board do 
  describe '#win_conditions_met?' do
    # Query method - Checks rows_win?/columns_win?/diagonals_win? and returns true/false accordingly
    subject(:board_won) { described_class.new }
    
    context 'when a row is filled with all Xs' do
      it 'returns true via #rows_win?' do
        board_won.cells[0] = 'X'
        board_won.cells[1] = 'X'
        board_won.cells[2] = 'X'
        expect(board_won.win_conditions_met?).to be true
      end
    end

    context 'when all 3 win conditions are false' do
      it 'returns false' do 
        board_won.instance_variable_set(:@cells, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        expect(board_won.win_conditions_met?).to be false
      end
    end
  end


  describe '#rows_win?' do 
    # Query Method - Returns true if any row is all Xs or all Os
    subject(:board_rows) { described_class.new }
    
    context 'when any of the 3 rows are all Xs or all Os' do
      it 'returns true when the first row is all Xs or all 0s' do
        board_rows.instance_variable_set(:@cells, ['X', 'X', 'X', 4, 5, 6, 7, 8, 9])
        expect(board_rows.rows_win?).to be true
        board_rows.instance_variable_set(:@cells, ['O', 'O', 'O', 4, 5, 6, 7, 8, 9])
        expect(board_rows.rows_win?).to be true
      end 

      it 'returns true when any row consists of all Xs' do
        board_rows.instance_variable_set(:@cells, [1, 2, 3, 'X', 'X', 'X', 7, 8, 9])
        expect(board_rows.rows_win?).to be true
        board_rows.instance_variable_set(:@cells, [1, 2, 3, 4, 5, 'X', 'X', 'X'])
      end
    end

    context 'when none of the 3 rows are all Xs or all 0s' do
      it 'returns false' do
        board_rows.instance_variable_set(:@cells, [1, 2, 3, 4, 5, 6, 7, 8, 9])
        expect(board_rows.rows_win?).to be false
      end

      it 'returns false when a row consists of Xs AND Os' do
        board_rows.instance_variable_set(:@cells, ['X', 'O', 'X', 4, 5, 6, 7, 8, 9])
        expect(board_rows.rows_win?).to be false
      end
    end
  end

  describe '#columns_win?' do
    # Query Method - Returns true if any column is all Xs or all Os
    subject(:board_columns) { described_class.new }

    context 'when any of the 3 columns are all Xs or all Os' do
      it 'returns true' do
        board_columns.instance_variable_set(:@cells, ['X', 2, 3, 'X', 5, 6, 'X', 8, 9])
        expect(board_columns.columns_win?).to be true
      end
    end

    context 'when none of the 3 columns are all Xs or all Os' do
      it 'returns false' do
        board_columns.instance_variable_set(:@cells, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'O'])
        expect(board_columns.columns_win?).to be false
      end
    end
  end

  describe '#diagonals_win?' do
    # Query Method - Returns true if either diagonal consists of all Xs or all Os
    subject(:board_diagonals) { described_class.new }

    context 'when either of the 2 diagonals are all Xs or all Os' do
      it 'returns true' do
        board_diagonals.instance_variable_set(:@cells, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'O', 'X'])
        expect(board_diagonals.diagonals_win?).to be true
        board_diagonals.instance_variable_set(:@cells, ['O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 'X'])
        expect(board_diagonals.diagonals_win?).to be true
      end
    end

    context 'when neither of the 2 diagonals consist of all Xs or all Os' do
      it 'returns false' do
        board_diagonals.instance_variable_set(:@cells, ['X', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'O'])
        expect(board_diagonals.diagonals_win?).to be false
      end
    end
  end


  describe '#full?' do
    # Query method - Returns true if the entire Board is filled with X/Os
    subject(:board_full) { described_class.new }

    it 'returns true when all @cells are either X or O' do
      board_full.instance_variable_set(:@cells, ['X', 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'O'])
      expect(board_full.full?).to be true
    end

    it 'returns false when not all cells are either X or 0' do
      board_full.instance_variable_set(:@cells, [0, 'O', 'X', 'X', 'O', 'X', 'O', 'X', 'O'])
      expect(board_full.full?).to be false
    end
  end


  describe '#update_cells' do
    # Command Method - Changes the state of the board (@cells)
    # => Test the change in state
    subject(:board_update) { described_class.new }

    context 'when given a number and a symbol(X/O)' do
      it 'changes the cell corresponding to the given number to the given symbol' do
        number = 6 
        index = number - 1
        symbol = 'X'

        expect{ board_update.update_cells(number, symbol) }.to change { board_update.cells[index] }.to(symbol)
      end
    end
  end
end