#!/usr/bin/env ruby
# frozen_string_literal: true

args = ARGV

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

def calc_filenames(filenames, is_l, is_w, is_c, is_all)
  total_l = 0
  total_w = 0
  total_c = 0
  filenames.each do |filename|
    strings = File.read(filename)
    result = ''
    result += format('% 8d', line_count(strings)) if is_l || is_all
    result += format('% 8d', word_count(strings)) if is_w || is_all
    result += format('% 8d', file_size(filename)) if is_c || is_all
    result += " #{filename}"
    puts result

    total_l += line_count(strings)
    total_w += word_count(strings)
    total_c += file_size(filename)
  end
  [total_l, total_w, total_c]
end

# 標準入力
def handle_stdin(str)
  result = ''
  result += format('% 8d', line_count(str))
  result += format('% 8d', word_count(str))
  result += format('% 8d', str.size)
  puts result
end

# パラメータ指定
def handle_param(filenames, is_l, is_w, is_c, is_all)
  total_l, total_w, total_c = calc_filenames(filenames, is_l, is_w, is_c, is_all)
  return unless filenames.size != 1

  total = ''
  total += format('% 8d', total_l) if is_l || is_all
  total += format('% 8d', total_w) if is_w || is_all
  total += format('% 8d', total_c) if is_c || is_all
  total += ' total'
  puts total
end

if args.size.zero?
  stdin = ARGF.gets('')
  handle_stdin(stdin)
else
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
  handle_param(filenames, is_l, is_w, is_c, is_all)
end
