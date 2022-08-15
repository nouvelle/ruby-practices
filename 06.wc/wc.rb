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

# 標準入力
def handle_stdin(str)
  result = ''
  result += format('% 8d', line_count(str))
  result += format('% 8d', word_count(str))
  result += format('% 8d', str.size)
  puts result
end

# パラメータ指定
def handle_param(filename, is_l, is_w, is_c)
  strings = File.read(filename)
  result = ''
  result += format('% 8d', line_count(strings)) if is_l
  result += format('% 8d', word_count(strings)) if is_w
  result += format('% 8d', file_size(filename)) if is_c
  result += " #{filename}"
  puts result
end

if args.size.zero?
  stdin = ARGF.gets('')
  handle_stdin(stdin)
else
  filename = args[0]

  if args[0]
    arg = args[0]
    if arg[0] == '-'
      is_l = arg.include?('l')
      is_w = arg.include?('w')
      is_c = arg.include?('c')
    end
    filename = args[1] if args[1]
  end

  handle_param(filename, is_l, is_w, is_c)
end
