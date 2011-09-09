#!/usr/bin/ruby

ARGF.each_line do |line|
  # strip line to avoid comparing newline character
  #break if line[0..-2] == "42"
  break if line.strip == "42"
  puts line
end
