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
        board_rows.instance_variable_set(:@cells, ['X', 'X', 'X', 3, 4, 5, 6, 7, 8])
        expect(board_rows.rows_win?).to be true
        board_rows.instance_variable_set(:@cells, ['O', 'O', 'O', 3, 4, 5, 6, 7, 8])
        expect(board_rows.rows_win?).to be true
      end 

      it 'returns true when any row consists of all Xs' do
        board_rows.instance_variable_set(:@cells, [0, 1, 2, 'X', 'X', 'X', 6, 7, 8])
        expect(board_rows.rows_win?).to be true
        board_rows.instance_variable_set(:@cells, [0, 1, 2, 3, 4, 5, 'X', 'X', 'X'])
      end
    end

    context 'when none of the 3 rows are all Xs or all 0s' do
      it 'returns false' do
        board_rows.instance_variable_set(:@cells, ['X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 8])
        expect(board_rows.rows_win?).to be false
      end
    end
  end




  describe '#full?' do
    # Query method - Returns true if the entire Board is filled with X/Os
    subject(:board_full) { described_class.new }

    xit 'returns true when all @cells are either X or O' do
      #allow(board_full).to receive(:cells).and_return
        
      #expect()
    end
  end
end