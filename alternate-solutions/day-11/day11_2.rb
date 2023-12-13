# frozen_string_literal: true

map = File.readlines('day11_example.txt').map(&:chomp)

coords = map.filter_map.with_index do |line, y|
  line.chars.filter_map.with_index do |char, x|
    [x, y] if char == '#'
  end
end

coords = coords.flatten(1)

increase = 99

(map.length - 1).downto(0).each do |y|
  next if map[y].include?('#')

  coords = coords.map { |coord| coord[1] > y ? [coord[0], coord[1] + increase] : coord }
end

map = map.map(&:chars).transpose.map(&:join)

(map.length - 1).downto(0).each do |x|
  unless map[x].include?('#')
    coords = coords.map { |coord| coord[0] > x ? [coord[0] + increase, coord[1]] : coord }
  end
end

sum = coords.combination(2).to_a.map do |a, b|
  (a[0] - b[0]).abs + (a[1] - b[1]).abs
end.sum

p sum
