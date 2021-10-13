require './lib/main'
require 'pry'

describe Game do
  describe '#initialize' do
    #Test any inside methods that are called
  end

  describe '#create_player' do
    # Contains puts and gets statements; returns a Player object
  end
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  describe '#game_over?' do
    subject(:game_over) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    before do
      allow(board).to receive(:win_conditions_met?).and_return(true)
    end

    it "returns true if the Board's win conditions are met" do
      
      
      
      expect(game_over.game_over?).to be true


    end

    xit "returns true if the Board is full (tie)" do
      
    end

    xit 'returns false if the Board is not full and win conditions are not met' do
      
    end
  end
end