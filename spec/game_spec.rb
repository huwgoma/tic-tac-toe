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

  describe '#play' do 
    # Looping Script Method - Test all inside methods
    subject(:game_play) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    it 'sends a message to Board to display the board' do
      allow(board).to receive(:display_board)
      expect(board).to receive(:display_board)

      game_play.play
    end
  end

  describe '#game_loop' do
    # Looping Script Method - Will loop until game_over?
    subject(:game_loop) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    xit "calls #player_input to collect the current player's move choice" do
      
    end
  end

  describe '#prompt_move_input' do
    # Puts method - Just test whether it asks @current_player for its name
    subject(:game_prompt) { described_class.new }
    let(:player) { instance_double(Player) }

    it 'asks @current_player for its name' do
      current_player_name = 'Lei'
      allow(player).to receive(:name).and_return(current_player_name)
      game_prompt.instance_variable_set(:@current_player, player)
      expect(player).to receive(:name).and_return(current_player_name)

      game_prompt.prompt_move_input
    end

  end

  describe '#player_input' do
    # Looping Script Method - Loop until a valid number (player move) is entered
    subject(:game_input) { described_class.new }

    it 'stops the loop when user_input is valid (verified); does not output error message' do
      user_input = '6'
      allow(game_input).to receive(:gets).and_return(user_input)
      verified_input = 6
      allow(game_input).to receive(:verify_input).and_return(verified_input)

      expect(game_input).to_not receive(:puts).with('Please enter a valid number!')
      game_input.player_input
    end
  end

  describe '#verify_input' do
    # Query Method - Returns the given number if it is valid; otherwise returns nil(?)
    subject(:game_verify) { described_class.new(board) }
    let(:board) { instance_double(Board) }

    it 'returns the given number if it is included in @cells' do
      allow(board).to receive(:cells).and_return([1, 2, 3, 4, 5, 6, 7, 8, 9])
      valid_number = 6
      expect(game_verify.verify_input(valid_number)).to eq(valid_number)
    end

    it 'returns nil if the number is not included in @cells' do
      allow(board).to receive(:cells).and_return([1, 2, 3, 4, 5, 'X', 7, 8, 9])
      invalid_number = 6
      expect(game_verify.verify_input(invalid_number)).to be nil
    end
  end
end



