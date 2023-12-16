# frozen_string_literal: true

input = File.readlines('day14_input.txt').map(&:chomp)

load = 0

input.size.times do |y|
  input[y].size.times do |x|
    next unless input[y][x] == 'O'

    next_y = y
    next_y -= 1 while next_y.positive? && input[next_y - 1][x] == '.'

    input[y][x] = '.'
    input[next_y][x] = 'O'

    load += input.size - next_y
  end
end

puts load
