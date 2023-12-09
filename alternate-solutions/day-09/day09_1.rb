# frozen_string_literal: true

input = File.read('day09_input.txt').split("\n").map(&:chomp).map do |line|
  line.split.map(&:to_i)
end

def extrapolate(series)
  return 0 if series.all?(&:zero?)

  next_series = series.each_cons(2).map { |a, b| b - a }
  diff = extrapolate(next_series)
  series.last + diff
end

p input.map { |series| extrapolate(series) }.sum
