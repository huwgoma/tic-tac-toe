# Player Class
class Player
  attr_reader :name, :player_id, :symbol
  
  def initialize(name, number)
    @name = name
    @player_id = number
    @symbol = @player_id == 1 ? 'X' : 'O'
  end
end