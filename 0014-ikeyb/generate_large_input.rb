#!/usr/bin/ruby

FILENAME = "input_large.txt"
NUM_CASES = 2000
LETTERS = Array.new(126-33+1) { |i| (i+33).chr }

info = []
info << "#{NUM_CASES}"
NUM_CASES.times do
  num_keys, num_letters = [ (rand * 90 + 1).to_i, (rand * 90 + 1).to_i ].sort
  LETTERS.shuffle[0,num_letters]

  info << "#{num_keys} #{num_letters}"
  info << LETTERS.shuffle[0,num_keys].join
  info << LETTERS.shuffle[0,num_letters].join
  num_letters.times { info << (rand * 100000).to_i }
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
