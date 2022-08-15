#!/usr/bin/env ruby
# frozen_string_literal: true

filename = ARGV[0]
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

puts "#{format("% 8d", line_count(strings))}#{format("% 8d", word_count(strings))}#{format("% 8d", file_size(filename))} #{filename}"

