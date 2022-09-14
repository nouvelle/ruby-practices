# frozen_string_literal: true

require_relative 'Shot'

class Frame
  attr_reader :first_shot, :second_shot

  def initialize(first_mark, second_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
  end

  def sum_score
    [first_shot.score, second_shot.score].sum
  end

  def strike?
    @first_shot.score == 10
  end
end
