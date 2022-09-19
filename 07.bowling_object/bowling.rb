# frozen_string_literal: true

require_relative 'Game'

args = ARGV[0]
puts Game.new(args).calc_score
