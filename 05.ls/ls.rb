#!/usr/bin/env ruby

COLUMN_NUMBER = 3
filenames = Dir.glob('*')
maxLength = 0

# ファイルデータ格納配列の初期値作成
def set_initial_arr(num)
  result = []
  (1..num).each do |num|
    result << []
  end
  result
end

# ファイル名表示メソッド
def print_filenames(filenames_arr, maxLength)
  return if filenames_arr.size == 0
  puts filenames_arr.map { |name| name.ljust(maxLength + 1)}.join
end

result = set_initial_arr(COLUMN_NUMBER)

filenames.each_with_index do |name, index|
  remainder = index % COLUMN_NUMBER
  maxLength = name.size if maxLength < name.size
  result[remainder] << name

end

print_filenames(result[0], maxLength)
print_filenames(result[1], maxLength)
print_filenames(result[2], maxLength)
