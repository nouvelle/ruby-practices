require 'date'
require 'optparse'

Week = ["日", "月", "火", "水", "木", "金", "土"]

# 今日の日付を取得
day = Date.today
showYear = day.year
showMonth = day.month

# 引数を取得
param = ARGV.getopts("m:", "y:")

# 表示する月を決める処理
if param["m"]
  month = param["m"].to_i
  if month >= 1 && month <= 12
    showMonth = month
    if param["y"]
      year = param["y"].to_i
      if year >= 1970 && year <= 2100
        showYear = year
      else
        # 戻す
        showMonth = day.month
      end 
    end 
  end 
end


## 結果出力
puts "      #{showMonth}月 #{showYear}"
puts Week.join(" ")

# 表示月の日付データ取得
isFirstDay = true
lastDay = Date.new(showYear, showMonth, -1)
(1..lastDay.day).each do |day|
  week = Date.new(showYear, showMonth, day).wday
  day = day <= 9 ? " #{day}" : day
  if isFirstDay
    space = "   " * week
    print "#{space}#{day}"
    isFirstDay = false
  else
    if week == 0
      print day
    else
      print " #{day}"
    end
  end

  if week == 6
    print "\n"
  end
end
print "\n"
