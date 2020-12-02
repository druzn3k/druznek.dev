# frozen_string_literal: true
require_relative './common'

input = read_input_lines(__FILE__)

lines = input.map do |line|
  line.split("x").map(&:to_i).sort
end

res1 = lines.reduce(0) { |acc,line| acc += line[0] * line[1] + line.combination(2).map { |x| 2 * x[0] * x[1] }.sum }
res2 = lines.reduce(0) { |acc,line| acc += (2 * line[0]) + (2 * line[1]) + line.reduce(&:*) }

puts res1, res2