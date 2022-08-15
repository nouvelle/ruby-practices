#!/usr/bin/env ruby
# frozen_string_literal: true

filename = ARGV[0]

if ARGV[0]
  arg = ARGV[0]
  if arg[0] == '-'
    is_l = arg.include?('l')
    is_w = arg.include?('w')
    is_c = arg.include?('c')
    filename = ARGV[1]
  end
end

strings = File.read(filename)

# 行数
def line_count(str)
  str.count("\n")
end

# 単語数
def word_count(str)
  arr = str.split(/\s+/)
  arr.size
end

# ファイルサイズ
def file_size(file)
  fs = File::Stat.new(file)
  fs.size
end

result = ''
result += "#{format("% 8d", line_count(strings))}" if is_l
result += "#{format("% 8d", word_count(strings))}" if is_w
result += "#{format("% 8d", file_size(filename))}" if is_c
result += " #{filename}"

puts result
