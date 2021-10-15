# Player Class
class Player
  attr_reader :name, :id, :symbol
  
  def initialize(name, number)
    @name = name
    @id = number
    @symbol = @id == 1 ? 'X' : 'O'
  end
end