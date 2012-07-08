#!/usr/bin/ruby

FILENAME = "input_large.txt"
num_cases = 2000
freqs = []
(33..126).each { |i| freqs << i.chr }

info = []
info << "#{num_cases}"
num_cases.times do
  num_keys, num_letters = [ (rand * 90 + 1).to_i, (rand * 90 + 1).to_i ].sort
  freqs.shuffle[0,num_letters]

  info << "#{num_keys} #{num_letters}"
  info << freqs.shuffle[0,num_keys].join
  info << freqs.shuffle[0,num_letters].join
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
