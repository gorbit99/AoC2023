# frozen_string_literal: true

map = File.readlines('day11_input.txt').map(&:chomp)

coords = map.map.with_index do |line, y|
  line.chars.map.with_index do |char, x|
    [x, y] if char == '#'
  end
end

coords = coords.flatten(1).compact

distances = coords.combination(2).map do |(x1, y1), (x2, y2)|
  (x1 - x2).abs + (y1 - y2).abs
end

p distances.sum
