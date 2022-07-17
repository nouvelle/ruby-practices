require 'date'
require 'optparse'

WEEK = ["日", "月", "火", "水", "木", "金", "土"]

# 今日の日付を取得
today = Date.today
show_year = today.year
show_month = today.month

# 引数を取得
param = ARGV.getopts("m:", "y:")

# 表示する月を決める処理
if param["m"]
  month = param["m"].to_i
  if month >= 1 && month <= 12  # if (1..12).include?(month) でもいける
    show_month = month
    if param["y"]
      year = param["y"].to_i
      if year >= 1970 && year <= 2100
        show_year = year
      else
        # 戻す
        show_month = today.month
      end 
    end 
  end 
end

## 結果出力
puts "      #{show_month}月 #{show_year}"
puts WEEK.join(" ")

# 表示月の日付データ取得
is_first_day = true
last_day = Date.new(show_year, show_month, -1)

(1..last_day.day).each do |day|
  show_space = ""
  week = Date.new(show_year, show_month, day).wday
  show_day = day.to_s.rjust(2)

  if is_first_day
    show_space = "   " * week
    is_first_day = false
  else
    show_space = " " if week != 0
  end

  # 今日だったら色を反転させる
  if Date.new(show_year, show_month, day) == today
    print "#{show_space}\e[7m#{show_day}\e[0m"
  else
    print "#{show_space}#{show_day}"
  end

  if Date.new(show_year, show_month, day).saturday?
    print "\n"
  end
end
print "\n"
