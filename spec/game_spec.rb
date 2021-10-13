require '../lib/main'
require 'pry'

describe Game do
  describe '#game_over?' do
    subject(:game_over) { described_class.new }
    let(:board) { instance_double(Board) }

    it "returns true if the Board's win conditions are met" do
      
      allow(board).to receive(:win_conditions_met?).and_return(true)
      
      expect(board).to receive(:win_conditions_met?)
      game_over.game_over?

    end

    xit "returns true if the Board is full (tie)" do
      
    end

    xit 'returns false if the Board is not full and win conditions are not met' do
      
    end
  end
end