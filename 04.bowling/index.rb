# frozen_string_literal: true

# 引数取得
args = ARGV[0]

# １投毎に分ける
score_arr = args.split(',')

# 文字列を数値に変換、'X' を 10 に変換
score_arr = score_arr.map { |score| score == 'X' ? 10 : score.to_i }

# 2投球を1フレームとしてまとめる
scores = []
prev_frame = []
score_arr.each do |score|
  prev_frame.push(score)
  if score == 10 || prev_frame.size == 2
    scores.push(prev_frame)
    prev_frame = []
  end
end
scores.push(prev_frame) unless prev_frame.empty?

# 最終フレームの場合の処理
frame10 = scores[9..11].flatten
scores = scores[0..8]
scores.push(frame10)

# 計算処理
total = scores.each_with_index.sum do |frame, index|
  frame_sum = frame.sum
  if index == 9
    frame_sum
  elsif frame[0] == 10
    next_score = scores[index + 1][0]
    next_next_score = scores[index + 1][1] || scores[index + 2][0]
    10 + next_score + next_next_score
  elsif frame_sum == 10
    next_score = scores[index + 1][0]
    frame_sum + next_score
  else
    frame_sum
  end
end

# 最終出力
puts total
