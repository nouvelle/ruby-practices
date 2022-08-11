#!/usr/bin/env ruby
# frozen_string_literal: true

require 'etc'

COLUMN_NUMBER = 3
glob_flag = ARGV.include?('-a') ? File::FNM_DOTMATCH : 0
filenames = Dir.glob('*', glob_flag)
filenames.sort!.reverse! if ARGV.include?('-r')
max_length = 0

FILE_TYPE = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze
PERMISSION_TYPE = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

if ARGV.include?('-l')
  size_max_length = 1
  block_size = 0
  filenames.each do |name|
    fs = File::Stat.new(name)
    block_size += fs.blocks
    size_max_length = fs.size.to_s.size if fs.size.to_s.size > size_max_length
  end
  puts "total #{block_size}"

  filenames.each do |name|
    fs = File::Stat.new(name)
    mode = format('%06d', fs.mode.to_s(8))
    permission = FILE_TYPE[mode[0, 2]]
    permission += PERMISSION_TYPE[mode[3]]
    permission += PERMISSION_TYPE[mode[4]]
    permission += "#{PERMISSION_TYPE[mode[5]]}  "
    permission += "#{fs.nlink} "
    permission += "#{Etc.getpwuid(fs.uid).name}  "
    permission += "#{Etc.getgrgid(fs.gid).name} "
    permission += "#{format("% #{size_max_length + 1}d", fs.size.to_s)} "
    permission += "#{fs.mtime.strftime('%b %e %R')} "
    permission += name
    puts permission
  end
  exit
end

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
