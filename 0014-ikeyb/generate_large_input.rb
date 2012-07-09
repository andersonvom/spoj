#!/usr/bin/ruby

FILENAME = "input_large.txt"
NUM_CASES = 2000
FIRST_VALID_CHAR = 33
LAST_VALID_CHAR = 126
MAX_KEYS = 90
MAX_LETTERS = 90
MAX_FREQUENCY = 100000

# sort valid chars for better visualization
ALL_CHARS = Array.new(LAST_VALID_CHAR-FIRST_VALID_CHAR+1) { |i| (i+FIRST_VALID_CHAR).chr }
letters = ALL_CHARS.collect{ |i| i if i =~ /[A-Za-z0-9]/ }.compact
VALID_CHARS = letters + (ALL_CHARS - letters)

info = []
info << "#{NUM_CASES}"
NUM_CASES.times do
  num_keys, num_letters = [ rand(MAX_KEYS)+1, rand(MAX_LETTERS)+1 ].sort

  info << "#{num_keys} #{num_letters}"
  info << VALID_CHARS[0,num_keys].join
  info << VALID_CHARS[0,num_letters].join
  num_letters.times { info << rand(MAX_FREQUENCY+1) }
end

begin
  File.open(FILENAME, 'w') do |f|
    f.puts info
  end
  puts "Large input file created: #{FILENAME}"
rescue
  STDOUT.puts info
  puts "# There was an error creating the file #{FILENAME}. Output redirected to screen."
  puts "# Lines starting with a '#' are not part of the input."
end
