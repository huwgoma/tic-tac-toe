require_relative '../lib/game_messages'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'

describe Game do
  before do 
    allow(STDOUT).to receive(:write)
  end

  describe '#initialize' do
    # Test any inside methods that are called
    # create_player - Contains puts and gets statements and returns a Player object
  end
  
  describe '#game_over?' do
    subject(:game_over) { described_class.new(board) }
    let(:board) { instance_double(Board) }
    
    it "returns true if the Board's win conditions are met" do
      allow(board).to receive(:win_conditions_met?).and_return(true)
      allow(board).to receive(:full?)
      expect(game_over.game_over?).to be true
    end
    
    it "returns true if the Board is full (tie)" do
      allow(board).to receive(:win_conditions_met?)
      allow(board).to receive(:full?).and_return(true)
      expect(game_over.game_over?).to be true  
    end

    it 'returns false if the Board is not full and win conditions are not met' do
      allow(board).to receive(:win_conditions_met?).and_return(false)
      allow(board).to receive(:full?).and_return(false)
      expect(game_over.game_over?).to be false
    end
  end
end



