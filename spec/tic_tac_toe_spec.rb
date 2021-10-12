require './main'

describe Game do
  describe '#initialize' do
    subject(:game_new) { described_class.new }
    
    before do 
      allow(game_new).to receive(:create_players)
    end

    it 'creates the two players' do
      expect(game_new).to receive(:create_players)
    end
  end
end