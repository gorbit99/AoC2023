# frozen_string_literal: true

hands = $stdin
        .each_line
        .map(&:split)
        .map { |cards, bid| [cards.chars, bid.to_i] }

card_values = 'AKQT98765432J'

hands.sort! do |a, b|
  a_non_joker = a[0].reject { |card| card == 'J' }
  b_non_joker = b[0].reject { |card| card == 'J' }
  a_duplications = a_non_joker.group_by(&:to_s).transform_values(&:length).values.sort.reverse
  b_duplications = b_non_joker.group_by(&:to_s).transform_values(&:length).values.sort.reverse

  a_duplications = [0] if a_duplications.empty?
  b_duplications = [0] if b_duplications.empty?

  a_duplications[0] += 5 - a_non_joker.length
  b_duplications[0] += 5 - b_non_joker.length

  next b_duplications <=> a_duplications if a_duplications != b_duplications

  a_values = a[0].map { |card| card_values.index(card) }
  b_values = b[0].map { |card| card_values.index(card) }

  a_values <=> b_values
end

p(hands.map.with_index do |hand, index|
  hand[1] * (hands.length - index)
end.sum)
