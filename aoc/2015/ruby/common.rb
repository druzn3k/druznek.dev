# frozen_string_literal: true

def read_input_file(file_name)
  fname = File.basename(file_name, '.rb')
  File.read(File.expand_path("../inputs/#{fname}.input", __dir__))
end

def read_input_lines(file_name)
  fname = File.basename(file_name, '.rb')
  File.readlines(File.expand_path("../inputs/#{fname}.input", __dir__))
end
