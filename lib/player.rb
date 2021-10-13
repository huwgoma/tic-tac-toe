# Player Class
class Player
  attr_reader :name, :player_id, :player_symbol
  
  def initialize(name, number)
    @name = name
    @player_id = number
    @player_symbol = @player_id == 1 ? 'X' : 'O'
  end
end