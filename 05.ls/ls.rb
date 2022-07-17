#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_NUMBER = 3
filenames = Dir.glob('*')
max_length = 0

# ファイルデータ格納配列の初期値作成
def make_initial_arr(num)
  result = []
  (1..num).each { result << [] }
  result
end

# ファイル名表示メソッド
def print_filenames(filenames_arr, max_length)
  return if filenames_arr.empty?

  puts filenames_arr.map { |name| name.ljust(max_length + 1) }.join
end

result = make_initial_arr(COLUMN_NUMBER)

filenames.each_with_index do |name, index|
  remainder = index % COLUMN_NUMBER
  max_length = name.size if max_length < name.size
  result[remainder] << name
end

print_filenames(result[0], max_length)
print_filenames(result[1], max_length)
print_filenames(result[2], max_length)
