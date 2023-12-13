# frozen_string_literal: true

input = File.read('day13_input.txt').split("\n\n").map(&:split).map do |line|
  line.map(&:chars)
end

def smudge(top, bottom)
  differences = top.length.times.sum do |y|
    top[y].length.times.count do |x|
      top[y][x] != bottom[y][x]
    end
  end

  differences == 1
end

def is_mirror_x(input, x)
  length = [x, input.size - x].min

  smudge(input[x - length...x], input[x...x + length].reverse)
end

def score(input)
  (1...input.size).each do |x|
    return x * 100 if is_mirror_x(input, x)
  end

  input = input.transpose

  (1...input.size).each do |x|
    return x if is_mirror_x(input, x)
  end

  0
end

scores = input.map { |i| score(i) }.sum

p scores
