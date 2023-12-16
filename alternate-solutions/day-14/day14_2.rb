# frozen_string_literal: true

input = File.readlines('day14_input.txt').map(&:chomp).map(&:chars)

def spin(input)
  input.size.times do |y|
    input[y].size.times do |x|
      next unless input[y][x] == 'O'

      next_y = y
      next_y -= 1 while next_y.positive? && input[next_y - 1][x] == '.'

      input[y][x] = '.'
      input[next_y][x] = 'O'
    end
  end

  input.size.times do |y|
    input[y].size.times do |x|
      next unless input[y][x] == 'O'

      next_x = x
      next_x -= 1 while next_x.positive? && input[y][next_x - 1] == '.'

      input[y][x] = '.'
      input[y][next_x] = 'O'
    end
  end

  (input.size - 1).downto(0) do |y|
    input[y].size.times do |x|
      next unless input[y][x] == 'O'

      next_y = y
      next_y += 1 while next_y < input.size - 1 && input[next_y + 1][x] == '.'

      input[y][x] = '.'
      input[next_y][x] = 'O'
    end
  end

  input.size.times do |y|
    (input[y].size - 1).downto(0) do |x|
      next unless input[y][x] == 'O'

      next_x = x
      next_x += 1 while next_x < input[y].size - 1 && input[y][next_x + 1] == '.'

      input[y][x] = '.'
      input[y][next_x] = 'O'
    end
  end
end

seen = []

seen << input.map(&:dup)
loop do
  spin(input)
  break if seen.include?(input)

  seen << input.map(&:dup)
end

index = seen.index(input)
delta = seen.size - index

last = (1_000_000_000 - index) % delta + index

last_state = seen[last]

load = last_state.map.with_index do |row, y|
  row.count('O') * (last_state.size - y)
end

p load.sum
