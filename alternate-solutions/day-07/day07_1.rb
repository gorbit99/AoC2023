# frozen_string_literal: true

hands = $stdin
        .each_line
        .map(&:split)
        .map { |cards, bid| [cards.chars, bid.to_i] }

card_values = 'AKQJT98765432'

hands.sort! do |a, b|
  a_duplications = a[0].group_by(&:to_s).transform_values(&:length).values.sort.reverse
  b_duplications = b[0].group_by(&:to_s).transform_values(&:length).values.sort.reverse

  next b_duplications <=> a_duplications if a_duplications != b_duplications

  a_values = a[0].map { |card| card_values.index(card) }
  b_values = b[0].map { |card| card_values.index(card) }

  a_values <=> b_values
end

p(hands.map.with_index do |hand, index|
  hand[1] * (hands.length - index)
end.sum)
