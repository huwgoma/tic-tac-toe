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
    # Query Method - Returns true or false
    # Method with outgoing Command - Test that messages are sent
    
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

    it 'sends #win_conditions_met? and #full? to Board' do
      allow(board).to receive(:win_conditions_met?)
      allow(board).to receive(:full?)
      expect(board).to receive(:win_conditions_met?)
      expect(board).to receive(:full?)

      game_over.game_over?
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
    # Looping Script Method - Will loop until game_over? - Test internal methods
    subject(:game_loop) { described_class.new(board) }
    let(:board) { instance_double(Board, win_conditions_met?: false, full?: false) }
    let(:player) { instance_double(Player) }

    context "when sending #update_cells to Board" do
      before do
        @input = 6
        allow(game_loop).to receive(:player_input).and_return(@input)
      end

      it 'sends #update_cells to Board with the current player symbol' do
        current_player_symbol = 'X'
        expect(board).to receive(:update_cells).with(@input, current_player_symbol)
        game_loop.game_loop
      end
    end

    context 'when game is not over' do
      xit 'changes the current player' do
        
      end
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
    
    before do
      allow(game_input).to receive(:prompt_move_input)
    end

    context 'when the user_input is valid' do
      it 'stops the loop; does not output error message' do
        valid_input = '6'
        allow(game_input).to receive(:gets).and_return(valid_input)
        
        expect(game_input).to_not receive(:puts).with('Please enter a valid number!')
        game_input.player_input
      end
    end

    context 'when the user_input is invalid once, then valid' do
      it 'completes the loop once; outputs error message once' do
        invalid_input = '0'
        valid_input = '6'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)

        expect(game_input).to receive(:puts).with('Please enter a valid number!').once
        game_input.player_input
      end
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


  describe '#switch_current_player' do
    # Command Method - Changes the @current_player to the other player
    subject(:game_switch_player) { described_class.new }
    let(:player_one) { instance_double(Player, id: 1) }
    let(:player_two) { instance_double(Player, id: 2) }

    before do
      allow(game_switch_player).to receive(:player_one).and_return(player_one)
      allow(game_switch_player).to receive(:player_two).and_return(player_two)
    end

    context 'when the current player is player 1' do
      it 'switches the current player to player 2' do
        game_switch_player.instance_variable_set(:@current_player, player_one)

        expect { game_switch_player.switch_current_player }.to change { game_switch_player.current_player }.to (player_two)
      end
    end
  end
end



