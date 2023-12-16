# frozen_string_literal: true

input = File.read('day15_input.txt').chomp.split(',')

input = input.map do |part|
  part.chars.reduce(0) do |acc, char|
    ((acc + char.ord) * 17) % 256
  end
end

p input.sum
