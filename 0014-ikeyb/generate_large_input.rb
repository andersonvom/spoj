#!/usr/bin/ruby


File.open("input_large.txt", 'w') do |f|

  num_cases = 2000
  freqs = []
  (33..126).each { |i| freqs << i.chr }

  f.puts "#{num_cases}"
  num_cases.times do
    num_keys, num_letters = [ (rand * 90 + 1).to_i, (rand * 90 + 1).to_i ].sort
    freqs.shuffle[0,num_letters]

    f.puts "#{num_keys} #{num_letters}"
    f.puts freqs.shuffle[0,num_keys].join
    f.puts freqs.shuffle[0,num_letters].join
    num_letters.times { f.puts (rand * 1000).to_i }
  end

end  

