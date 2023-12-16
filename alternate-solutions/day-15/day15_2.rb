# frozen_string_literal: true

input = File.read('day15_input.txt').chomp.split(',')

boxes = Array.new(256) { [] }

input.each do |part|
  label, operation, param = part.match(/([^-=]+)([-=])(.*)/)[1..3]

  hash = label.chars.reduce(0) do |acc, c|
    ((acc + c.ord) * 17) % 256
  end

  if operation == '-'
    boxes[hash] = boxes[hash].reject { |lens| lens[0] == label }
  else
    index = boxes[hash].index { |lens| lens[0] == label }
    if index
      boxes[hash][index][1] = param.to_i
    else
      boxes[hash] << [label, param.to_i]
    end
  end
end

boxes = boxes.map.with_index do |lenses, i|
  values = lenses.map.with_index do |lens, j|
    lens[1] * (i + 1) * (j + 1)
  end

  values.sum
end

p boxes.sum
