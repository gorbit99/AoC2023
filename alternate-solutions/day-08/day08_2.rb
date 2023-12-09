# frozen_string_literal: true

input = File.read('day08_input.txt').split("\n").map(&:chomp)

steps = input[0]
nodes = input[2..]
        .map do |line|
  start, directions = line.split(' = ')
  left, right = directions[1..-2].split(', ')
  [start, [left, right]]
end.to_h

def find_interval(steps, start, nodes)
  taken = 0
  step = 0

  current = start

  until current.end_with?('Z')
    current = nodes[current][steps[step] == 'L' ? 0 : 1]
    taken += 1
    step += 1
    step = 0 if step == steps.length
  end

  taken
end

start_nodes = nodes.keys.filter { |k| k.end_with?('A') }

intervals = start_nodes.map { |start| find_interval(steps, start, nodes) }
p intervals.reduce(:lcm)
