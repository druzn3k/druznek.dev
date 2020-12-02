# frozen_string_literal: true

require_relative './common'

input = read_input_lines(__FILE__)

class PasswordValidator1
  REXP = /(?<rstart>\d+)-(?<rend>\d+)\s+(?<policy>[a-z]):\s+(?<password>\w+)/

  def initialize(line)
    matches = REXP.match(line)

    @range = Range.new(matches[:rstart].to_i, matches[:rend].to_i)
    @policy = matches[:policy]
    @password = matches[:password]
  end

  def valid?
    kount = 0
    @password.each_char { |c| kount += 1 if c == @policy }

    @range.include?(kount)
  end
end

class PasswordValidator2
  REXP = /(?<idx1>\d+)-(?<idx2>\d+)\s+(?<policy>[a-z]):\s+(?<password>\w+)/

  def initialize(line)
    matches = REXP.match(line)

    @first = matches[:idx1].to_i
    @second = matches[:idx2].to_i
    @policy = matches[:policy]
    @password = matches[:password]
  end

  def valid?
    (@password[@first-1] == @policy) ^ (@password[@second-1] == @policy)
  end
end

result = read_input_lines(__FILE__).each_with_object(Hash.new(0)) do |line, h|
  if PasswordValidator1.new(line).valid?
    h["valid"] += 1
  else
    h["invalid"] += 1
  end
end

puts result

result = read_input_lines(__FILE__).each_with_object(Hash.new(0)) do |line, h|
  if PasswordValidator2.new(line).valid?
    h["valid"] += 1
  else
    h["invalid"] += 1
  end
end

puts result
