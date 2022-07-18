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
  show_month = month if (1..12).cover?(month)
else
  show_month = today.month
end

## タイトル（年月・曜日）出力
puts "      #{show_month}月 #{show_year}"
puts WEEK.join(' ')

# 表示月の日付データ取得
last_day = Date.new(show_year, show_month, -1)

# 1日の左のスペースを表示
week = Date.new(show_year, show_month, 1).wday
print('   ' * week)

(1..last_day.day).each do |day|
  target_day = Date.new(show_year, show_month, day)
  week = target_day.wday
  show_day = day.to_s.rjust(2)
  # 今日だったら色を反転させる
  show_day = "\e[7m#{show_day}\e[0m" if target_day == today
  print " #{show_day}"
  print "\n" if target_day.saturday?
end
print "\n"
