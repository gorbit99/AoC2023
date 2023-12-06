# frozen_string_literal: true

input = File.read('day06_input.txt').split("\n").map do |line|
  line.split(' ')[1..].map(&:to_i)
end

input = input[0].zip(input[1])

def solutions(race)
  time, distance = race

  d = Math.sqrt(time**2 - 4 * distance)

  min = ((-time - d) / 2 + 1).floor
  max = ((-time + d) / 2 - 1).ceil

  max - min + 1
end

p input.map(&method(:solutions)).reduce(:*)
