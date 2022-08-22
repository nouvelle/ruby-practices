#!/usr/bin/env ruby
# frozen_string_literal: true

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
def file_size(file)
  fs = File::Stat.new(file)
  fs.size
end

# ファイルの計算
def calc_filename(filename, is_l, is_w, is_c, is_all)
  string_of_file = File.read(filename)
  l = format('% 8d', line_count(string_of_file)) if is_l || is_all
  w = format('% 8d', word_count(string_of_file)) if is_w || is_all
  c = format('% 8d', file_size(filename)) if is_c || is_all
  [l, w, c]
end

# 標準入力
def handle_stdin(string, is_l, is_w, is_c, is_all)
  result = ''
  result += format('% 8d', line_count(string)) if is_l || is_all
  result += format('% 8d', word_count(string)) if is_w || is_all
  result += format('% 8d', string.size) if is_c || is_all
  puts result
end

if args[0]
  arg = args[0]
  if arg[0] == '-'
    is_l = arg.include?('l')
    is_w = arg.include?('w')
    is_c = arg.include?('c')
    filenames = args[1..]
  else
    filenames = args
  end
end

is_all = true if !is_l && !is_w && !is_c
total_l = 0
total_w = 0
total_c = 0

if File.pipe?($stdin)
  stdin = $stdin.gets('')
  handle_stdin(stdin, is_l, is_w, is_c, is_all)
else
  filenames.each do |filename|
    l, w, c = calc_filename(filename, is_l, is_w, is_c, is_all)
    total_l += l.to_i
    total_w += w.to_i
    total_c += c.to_i
    puts "#{l}#{w}#{c} #{filename}"
  end
  return unless filenames.size != 1

  total = ''
  total += format('% 8d', total_l) if is_l || is_all
  total += format('% 8d', total_w) if is_w || is_all
  total += format('% 8d', total_c) if is_c || is_all
  total += ' total'
  puts total
end
