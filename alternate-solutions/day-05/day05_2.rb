# frozen_string_literal: true

input = File.read('day05_input.txt').split("\n").map(&:chomp)

seeds = input[0].split(' ')[1..].map(&:to_i).each_slice(2).to_a.map { |start, length| [start, start + length] }

maps = [[]]

input[2..].each do |line|
  if line == ''
    maps << []
    next
  end

  next if line.end_with?(':')

  map = line.split(' ').map(&:to_i)

  map = [
    map[1],
    map[1] + map[2],
    map[0]
  ]

  maps[-1] << map
end

maps = maps.map { |map| map.sort_by { |row| row[0] } }

def map_range(seed, map)
  new_ranges = map.filter_map do |row|
    next if seed[1] == seed[0]

    next [seed] if seed[1] < row[0]
    next if seed[0] > row[1]

    result = []
    if seed[0] < row[0]
      result << [seed[0], row[0] - 1]
      seed[0] = row[0]
    end

    range_end = [seed[1], row[1]].min

    result << [seed[0] + (row[2] - row[0]), range_end + (row[2] - row[0])]
    seed[0] = range_end
    result
  end
  new_ranges = new_ranges.flatten(1)
  new_ranges << seed if seed[1] > seed[0]

  new_ranges
end

def map_each(maps, seed_range)
  maps.reduce([seed_range]) do |seed, map|
    seed.map { |s| map_range(s, map) }.flatten(1)
  end
end

p seeds.map { |seed| map_each(maps, seed) }.flatten(1).map { |seed| seed[0] }.min
