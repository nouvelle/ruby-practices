# frozen_string_literal: true

require 'minitest/autorun'
require '../Game'

class GameTest < Minitest::Test
  def test_game
    game1 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,6,4,5')
    assert_equal 139, game1.calc_score

    game2 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,X,X')
    assert_equal 164, game2.calc_score

    game3 = Game.new('0,10,1,5,0,0,0,0,X,X,X,5,1,8,1,0,4')
    assert_equal 107, game3.calc_score

    game4 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,0,0')
    assert_equal 134, game4.calc_score

    game5 = Game.new('6,3,9,0,0,3,8,2,7,3,X,9,1,8,0,X,X,1,8')
    assert_equal 144, game5.calc_score

    game6 = Game.new('X,X,X,X,X,X,X,X,X,X,X,X')
    assert_equal 300, game6.calc_score
  end
end
