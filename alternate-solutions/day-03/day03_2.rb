# frozen_string_literal: true

map = File.readlines('day03_input.txt').map(&:chomp)

numbers = []
gears = []

map.each.with_index do |line, y|
  line.enum_for(:scan, /\d+/).filter do |number|
    x = Regexp.last_match.begin(0)
    length = number.length

    number = [number.to_i, []]

    length.times do |i|
      number[1] << [x + i, y]
    end

    numbers << number
  end

  line.enum_for(:scan, /\*/).filter do
    x = Regexp.last_match.begin(0)

    gears << [x, y]
  end
end

gears = gears.filter_map do |gear|
  x, y = gear

  adjacent = []

  (x - 1..x + 1).each do |dx|
    (y - 1..y + 1).each do |dy|
      next if x == dx && y == dy

      adjacent << [dx, dy]
    end
  end

  adjacent_numbers = numbers.filter_map do |number|
    number[0] if number[1].any? { |n| adjacent.include?(n) }
  end

  adjacent_numbers.length != 2 ? nil : adjacent_numbers.reduce(:*)
end

p gears.sum
