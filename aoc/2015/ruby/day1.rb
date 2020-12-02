# frozen_string_literal: true
require_relative './common'

input = read_input_file(__FILE__)

count = 0
minus_one_index = -1

input.each_char.with_index do |c, idx|
  count += case c
           when '(' then 1
           when ')' then -1
           else 0
           end

  if count == -1 && minus_one_index == -1
    minus_one_index = idx + 1
  end
end

puts count, minus_one_index
