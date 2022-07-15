# 引数取得
args = ARGV[0]

# １投毎に分ける
scoreArr = args.split(",")

# フレームごとに分割
scores = []
tmpScore = []
scoreArr.each_with_index do |score, index|
  # 最終フレームの場合
  if scores.size == 9
    score = "10" if score == "X"
    tmpScore.push(score)
    if index == scoreArr.size - 1
      scores.push(tmpScore)
      tmpScore = []
    end
  else
    if score == "X"
      scores.push(["10"])
    elsif tmpScore.size == 0
      tmpScore.push(score)
    elsif tmpScore.size == 1
      tmpScore.push(score)
      scores.push(tmpScore)
      tmpScore = []
    end
  end
end

# 計算処理
scoresSum = 0
scores.each_with_index do |frame, index|
  frameSum = frame.sum { |n| n.to_i }
  if index == 9
    scoresSum += frameSum
  else
    if frame[0] == "10"
      nextScore = scores[index + 1][0].to_i
      nextNextScore = scores[index + 1][1] ? scores[index + 1][1].to_i : scores[index + 2][0].to_i
      scoresSum += (10 + nextScore + nextNextScore)
    elsif frameSum == 10
      nextScore = scores[index + 1][0].to_i
      scoresSum += (frameSum + nextScore)
    else
      scoresSum += frameSum
    end
  end
end

# 最終出力
puts scoresSum
