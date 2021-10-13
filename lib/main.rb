# frozen_string_literal: true
require_relative 'board' 
require_relative 'player'
require_relative 'game_messages'
require_relative 'game'

require 'pry'

game = Game.new
game.play