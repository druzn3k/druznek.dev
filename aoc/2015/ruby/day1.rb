# frozen_string_literal: true

fname = File.basename(__FILE__, '.rb')
input = File.read(File.expand_path("../inputs/#{fname}.input", __dir__))

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
