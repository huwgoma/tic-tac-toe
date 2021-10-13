require_relative '../lib/game_messages'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Board do 
  describe '#win_conditions_met?' do
    # Query method - Checks rows_win?/columns_win?/diagonals_win? and returns true/false accordingly
    subject(:board_won) { described_class.new }
    
    context 'when only rows_won? is true' do
      it 'returns true' do
        allow(board_won).to receive(:rows_win?).and_return(true) 
        allow(board_won).to receive(:columns_win?)
        allow(board_won).to receive(:diagonals_win?)
        
        expect(board_won.win_conditions_met?).to be true
      end
    end

    context 'when all 3 win conditions are true' do
      it 'returns true' do
        allow(board_won).to receive(:rows_win?).and_return(true) 
        allow(board_won).to receive(:columns_win?).and_return(true) 
        allow(board_won).to receive(:diagonals_win?).and_return(true) 

        expect(board_won.win_conditions_met?).to be true
      end
    end

    context 'when all 3 win conditions are false' do
      it 'returns false' do 
        allow(board_won).to receive(:rows_win?)
        allow(board_won).to receive(:columns_win?)
        allow(board_won).to receive(:diagonals_win?)

        expect(board_won.win_conditions_met?).to be false
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