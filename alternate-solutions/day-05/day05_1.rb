# frozen_string_literal: true

input = File.read('day05_input.txt').split("\n").map(&:chomp)

seeds = input[0].split(' ')[1..].map(&:to_i)

maps = [[]]

input[2..].each do |line|
  if line == ''
    maps << []
    next
  end

  next if line.end_with?(':')

  map = line.split(' ').map(&:to_i)
  maps[-1] << map
end

def map(maps, seed)
  maps.each do |map|
    containing = map.find do |row|
      seed >= row[1] && seed <= row[1] + row[2]
    end

    next if containing.nil?

    seed = seed - containing[1] + containing[0]
  end

  seed
end

seeds = seeds.map { |seed| map(maps, seed) }
p seeds.min
