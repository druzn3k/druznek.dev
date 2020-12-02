# frozen_string_literal: true

require_relative './common'

SUM_EXPECTED = 2020

inputs = read_input_file(__FILE__).split("\n").map(&:to_i)

def search_for_numbers(sum, inputs, ignore_index = -1)
  result = nil
  inputs.each_with_object({}).with_index do |(n,h), idx|
    next if ignore_index == idx
    k = sum - n;
    h[k] ? result = [n, k] : h[n] = true
  end

  result
end

part1 = search_for_numbers(SUM_EXPECTED, inputs)

part2 = nil
inputs.each_with_index do |n, idx|
  x = SUM_EXPECTED - n;
  part2_temp = search_for_numbers(x, inputs, idx)

  if part2_temp
    part2 = [n, part2_temp].flatten
    break
  end
end

puts "#{part1[0]} x #{part1[1]} = #{part1[0] * part1[1]}"
puts "#{part2[0]} x #{part2[1]} x #{part2[2]} = #{part2[0] * part2[1] * part2[2]}"