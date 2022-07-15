# frozen_string_literal: true

# 引数取得
args = ARGV[0]

# １投毎に分ける
score_arr = args.split(',')

# フレームごとに分割
scores = []
tmp_score = []
score_arr.each_with_index do |score, index|
  # 最終フレームの場合
  if scores.size == 9
    score = '10' if score == 'X'
    tmp_score.push(score)
    if index == score_arr.size - 1
      scores.push(tmp_score)
      tmp_score = []
    end
  elsif score == 'X'
    scores.push(['10'])
  elsif tmp_score.empty?
    tmp_score.push(score)
  elsif tmp_score.size == 1
    tmp_score.push(score)
    scores.push(tmp_score)
    tmp_score = []
  end
end

# 計算処理
scores_sum = 0
scores.each_with_index do |frame, index|
  frame_sum = frame.sum(&:to_i)
  if index == 9
    scores_sum += frame_sum
  elsif frame[0] == '10'
    next_score = scores[index + 1][0].to_i
    next_next_score = scores[index + 1][1] ? scores[index + 1][1].to_i : scores[index + 2][0].to_i
    scores_sum += (10 + next_score + next_next_score)
  elsif frame_sum == 10
    next_score = scores[index + 1][0].to_i
    scores_sum += (frame_sum + next_score)
  else
    scores_sum += frame_sum
  end
end

# 最終出力
puts scores_sum
