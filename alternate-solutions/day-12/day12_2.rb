# frozen_string_literal: true

CACHE = {}

def cached(groups, codes, value)
  CACHE[[groups, codes]] = value
  value
end

def solutions(groups, codes)
  return CACHE[[groups, codes]] if CACHE.key?([groups, codes])

  return cached(groups, codes, 0) if groups.empty? && !codes.empty?
  return cached(groups, codes, 0) if codes.empty? && groups.any? { |group| group.include?('#') }
  return cached(groups, codes, 1) if codes.empty?

  current_group = groups[0]
  current_code = codes[0]

  if current_group.size < current_code && !current_group.include?('#')
    return cached(groups, codes,
                  solutions(groups[1..], codes))
  end
  return cached(groups, codes, 0) if current_group.size < current_code

  total = 0

  if current_group[0] == '?'
    # Handle if first is .
    remaining = if current_group.size > 1
                  solutions([current_group[1..], *groups[1..]], codes)
                else
                  solutions(groups[1..], codes)
                end
    total += remaining
  end

  return cached(groups, codes, total) if current_group[current_code] == '#'

  # Handle if first is #
  if current_group.size > current_code + 1
    remaining = solutions([current_group[current_code + 1..], *groups[1..]], codes[1..])
    return cached(groups, codes, remaining + total)
  end

  remaining = solutions(groups[1..], codes[1..])
  cached(groups, codes, remaining + total)
end

input = File.readlines('day12_input.txt').map(&:split).map do |line|
  text = ([line[0]] * 5).join('?')
  codes = line[1].split(',').map(&:to_i) * 5

  groups = text.scan(/[?#]+/)
  solutions(groups, codes)
end

p input.sum
