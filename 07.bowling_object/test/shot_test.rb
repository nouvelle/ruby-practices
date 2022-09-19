# frozen_string_literal: true

require 'minitest/autorun'
require '../shot'

class ShotTest < Minitest::Test
  def test_mark
    shot1 = Shot.new('1')
    assert_equal '1', shot1.mark
    assert_equal 1, shot1.score
  end
end
