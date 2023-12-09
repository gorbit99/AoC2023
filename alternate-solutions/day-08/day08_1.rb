# frozen_string_literal: true

input = File.read('day08_input.txt').split("\n").map(&:chomp)

steps = input[0]
nodes = input[2..]
        .map do |line|
  start, directions = line.split(' = ')
  left, right = directions[1..-2].split(', ')
  [start, [left, right]]
end.to_h

pos = 'AAA'
step = 0
taken = 0

while pos != 'ZZZ'
  taken += 1
  pos = nodes[pos][steps[step] == 'L' ? 0 : 1]
  step += 1
  step = 0 if step == steps.length
end

p taken
