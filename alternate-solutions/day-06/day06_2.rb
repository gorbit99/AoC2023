# frozen_string_literal: true

input = File.read('day06_input.txt').split("\n").map do |line|
  line.split(' ')[1..].join.to_i
end

def solutions(race)
  time, distance = race

  d = Math.sqrt(time**2 - 4 * distance)

  min = ((-time - d) / 2 + 1).floor
  max = ((-time + d) / 2 - 1).ceil

  max - min + 1
end

p solutions(input)
