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

row_number = filenames.size / COLUMN_NUMBER
row_number += 1 if filenames.size % COLUMN_NUMBER != 0
result = make_initial_arr(row_number)

amari = filenames.size % COLUMN_NUMBER

(1..filenames.size).each_with_index do |order, index|
  max_length = filenames[index].size if max_length < filenames[index].size
  if amari > 0
    remainder = index % row_number
    result[remainder] << filenames[index]
    amari -= 1 if remainder == row_number - 1
  else
    remainder = (index - (row_number * (filenames.size % COLUMN_NUMBER))) % (filenames.size / COLUMN_NUMBER)
    result[remainder] << filenames[index]
  end
end

n = 0
while n < row_number
  print_filenames(result[n], max_length)
  n += 1
end
