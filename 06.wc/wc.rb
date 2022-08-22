#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

params = ARGV.getopts('lwc')
args = ARGV

# 行数
def line_count(string)
  string.count("\n")
end

# 単語数
def word_count(string)
  arr = string.split(/\s+/)
  arr.size
end

# ファイルサイズ
def file_size(string)
  string.size
end

# 渡された文字列の計算
def calc_string(string, is_l, is_w, is_c, is_all)
  lines_part = format('% 8d', line_count(string)) if is_l || is_all
  words_part = format('% 8d', word_count(string)) if is_w || is_all
  bytes_part = format('% 8d', file_size(string)) if is_c || is_all
  [lines_part, words_part, bytes_part]
end

is_l = params['l']
is_w = params['w']
is_c = params['c']
filenames = args if args.size.nonzero?

is_all = true if !is_l && !is_w && !is_c
total_l = 0
total_w = 0
total_c = 0

if File.pipe?($stdin)
  stdin = $stdin.gets('')
  lines_part, words_part, bytes_part = calc_string(stdin, is_l, is_w, is_c, is_all)
  puts "#{lines_part}#{words_part}#{bytes_part}"
else
  filenames.each do |filename|
    string_of_file = File.read(filename)
    lines_part, words_part, bytes_part = calc_string(string_of_file, is_l, is_w, is_c, is_all)
    total_l += lines_part.to_i
    total_w += words_part.to_i
    total_c += bytes_part.to_i
    puts "#{lines_part}#{words_part}#{bytes_part} #{filename}"
  end
  return unless filenames.size != 1

  total = ''
  total += format('% 8d', total_l) if is_l || is_all
  total += format('% 8d', total_w) if is_w || is_all
  total += format('% 8d', total_c) if is_c || is_all
  total += ' total'
  puts total
end
