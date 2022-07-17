# frozen_string_literal: true

require 'date'
require 'optparse'

WEEK = %w[日 月 火 水 木 金 土].freeze

# 今日の日付を取得
today = Date.today
show_year = today.year
show_month = today.month

# 引数を取得
param = ARGV.getopts('m:', 'y:')

# 表示する月を決める処理
month = param['m'].to_i
year = param['y'].to_i

if param['m'] && param['y']
  if (1..12).cover?(month) && (1970..2100).cover?(year)
    show_month = month
    show_year = year
  end
elsif param['m'] && !param['y']
  show_month = month if month >= 1 && month <= 12
else
  show_month = today.month
end

## 結果出力
puts "      #{show_month}月 #{show_year}"
puts WEEK.join(' ')

# 表示月の日付データ取得
is_first_day = true
last_day = Date.new(show_year, show_month, -1)

(1..last_day.day).each do |day|
  show_space = ''
  week = Date.new(show_year, show_month, day).wday
  show_day = day.to_s.rjust(2)

  if is_first_day
    show_space = '   ' * week
    is_first_day = false
  elsif week != 0
    show_space = ' '
  end

  # 今日だったら色を反転させる
  if Date.new(show_year, show_month, day) == today
    print "#{show_space}\e[7m#{show_day}\e[0m"
  else
    print "#{show_space}#{show_day}"
  end

  print "\n" if Date.new(show_year, show_month, day).saturday?
end
print "\n"
