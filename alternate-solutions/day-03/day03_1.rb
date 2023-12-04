# frozen_string_literal: true

map = File.readlines('day03_input.txt').map(&:chomp)

sum = 0

map.each.with_index do |line, y|
  line.enum_for(:scan, /\d+/).filter do |number|
    x = Regexp.last_match.begin(0)
    length = number.length
    found = false
    (x - 1..x + length).each do |dx|
      break if found

      (y - 1..y + 1).each do |dy|
        next if dx.negative? || dy.negative? || dx >= line.length || dy >= map.length

        symbol = map[dy][dx]
        next if symbol == '.'
        next if ('0'..'9').include?(symbol)

        found = true
        break
      end
    end

    sum += number.to_i if found
  end
end

p sum
