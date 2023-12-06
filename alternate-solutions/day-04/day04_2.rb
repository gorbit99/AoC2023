# frozen_string_literal: true

require 'set'

input = File.read('day04_input.txt').each_line.map do |line|
  _, data = line.split(': ')
  winner_string, numbers_string = data.split(' | ')
  winners = Set.new(winner_string.split(' '))
  numbers = Set.new(numbers_string.split(' '))
  won = (winners & numbers).size

  won
end

cards = [1] * input.size

input.each_with_index do |won, card_num|
  won.times do |i|
    cards[card_num + i + 1] += cards[card_num]
  end
end

p cards.sum
