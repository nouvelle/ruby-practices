#!/usr/bin/env ruby

# frozen_string_literal: true

COLUMN_NUMBER = 3
filenames = Dir.glob('*')
all_filenames = Dir.glob('*', File::FNM_DOTMATCH)
max_length = 0

filenames = all_filenames if ARGV.include?('-a')

# ファイルデータ格納配列の初期値作成
def make_initial_arr(num)
  Array.new(num) { [] }
end

# ファイル名表示メソッド
def print_filenames(filenames_arr, max_length)
  return if filenames_arr.empty?

  puts filenames_arr.map { |name| name.ljust(max_length + 1) }.join
end

row_number = filenames.size / COLUMN_NUMBER
row_number += 1 if filenames.size % COLUMN_NUMBER != 0
result = make_initial_arr(row_number)

filenames.each_with_index do |name, index|
  max_length = filenames[index].size if max_length < filenames[index].size
  remainder = index % row_number
  result[remainder] << name
end

row_number.times { |n| print_filenames(result[n], max_length) }
