# Player Class
class Player
  @@number_of_players = 0

  def self.number_of_players=(value)
    @@number_of_players = value
  end

  def initialize(name)
    @name = name
    @@number_of_players += 1
    @player_id = @@number_of_players
    @player_symbol = @player_id == 1 ? 'X' : 'O'
  end

  attr_reader :name, :player_id, :player_symbol
end