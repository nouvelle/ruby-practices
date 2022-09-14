# frozen_string_literal: true

require_relative 'Frame'

class Game
  def initialize(game_scores)
    @game_scores = game_scores.split(',')
  end

  def calc_score
    split_frame.each_with_index.sum do |f, i|
      frame_sum = f.sum_score
      next_frame = split_frame[i + 1]

      if i >= 9 || frame_sum < 10
        frame_sum
      elsif f.strike?
        next_score = next_frame.first_shot.score
        next_next_score = next_frame.strike? ? split_frame[i + 2].first_shot.score : next_frame.second_shot.score
        10 + next_score + next_next_score
      elsif frame_sum == 10
        next_score = next_frame.first_shot.score
        frame_sum + next_score
      end
    end
  end

  private

  def split_frame
    scores = []
    prev_frame = []
    @game_scores.each do |score|
      prev_frame.push(score)
      if score == 'X' || prev_frame.size == 2
        scores.push(prev_frame)
        prev_frame = []
      end
    end
    scores.push(prev_frame) unless prev_frame.empty?
    scores.map { |frame| Frame.new(*frame) }
  end
end
