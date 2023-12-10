# frozen_string_literal: true

pipes = File.readlines('day10_input.txt').map(&:chomp)

start_coord = pipes.filter_map.with_index { |row, y| row.index('S') ? [row.index('S'), y] : nil }.first

path = [[*start_coord]]

loop do
  current_coord = path.last

  current_char = pipes[current_coord[1]][current_coord[0]]

  break if current_char == 'S' && path.length > 1

  possible_ways = case current_char
                  when 'S'
                    [[current_coord[0], current_coord[1] + 1]]
                  when '|'
                    [[current_coord[0], current_coord[1] - 1], [current_coord[0], current_coord[1] + 1]]
                  when '-'
                    [[current_coord[0] - 1, current_coord[1]], [current_coord[0] + 1, current_coord[1]]]
                  when 'L'
                    [[current_coord[0] + 1, current_coord[1]], [current_coord[0], current_coord[1] - 1]]
                  when 'F'
                    [[current_coord[0] + 1, current_coord[1]], [current_coord[0], current_coord[1] + 1]]
                  when '7'
                    [[current_coord[0] - 1, current_coord[1]], [current_coord[0], current_coord[1] + 1]]
                  when 'J'
                    [[current_coord[0] - 1, current_coord[1]], [current_coord[0], current_coord[1] - 1]]
                  end
  next_coord = possible_ways.find { |coord| coord != path[-2]&.[](0..1) }

  if 'SF7|'.include?(current_char)
    path.last[2] = next_coord == [current_coord[0], current_coord[1] + 1] ? :down : :up
  end

  if 'LJ'.include?(current_char)
    path.last[2] = next_coord == [current_coord[0], current_coord[1] - 1] ? :up : :down
  end

  path << next_coord
end

contained = Set.new

pipes.size.times do |y|
  row_path = path.filter do |coord|
               coord[1] == y && !coord[2].nil?
             end.map { |coord| [coord[0], coord[2]] }.sort_by(&:first)

  required = row_path[0][1]
  state = nil

  row_path.each.with_index do |coord, i|
    if state == required && coord[1] != required
      prev = row_path[i - 1]
      (prev[0]..coord[0]).each { |x| contained << [x, y] }
    end
    state = coord[1]
  end
end

path_points = path.map { |coord| [coord[0], coord[1]] }

puts (contained - path_points).length
