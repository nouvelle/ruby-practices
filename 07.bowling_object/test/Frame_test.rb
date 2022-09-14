# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../Frame'

class FrameTest < Minitest::Test
  def test_frame
    frame1 = Frame.new('3', '5')
    assert_equal 3, frame1.first_shot.score
    assert_equal 5, frame1.second_shot.score
    assert_equal 8, frame1.sum_score
    assert_equal false, frame1.strike?

    frame2 = Frame.new('1', '9')
    assert_equal 1, frame2.first_shot.score
    assert_equal 9, frame2.second_shot.score
    assert_equal 10, frame2.sum_score
    assert_equal false, frame2.strike?

    frame3 = Frame.new('X', '0')
    assert_equal 10, frame3.first_shot.score
    assert_equal 0, frame3.second_shot.score
    assert_equal 10, frame3.sum_score
    assert_equal true, frame3.strike?

    frame4 = Frame.new('1')
    assert_equal 1, frame4.first_shot.score
    assert_equal 0, frame4.second_shot.score
    assert_equal 1, frame4.sum_score
    assert_equal false, frame4.strike?
  end
end
