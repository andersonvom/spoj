#!/usr/bin/ruby

module SPOJ

  class IKeyboard

    def self.solve(keys, letters, frequencies)
    end

  end

end


if __FILE__ == $0
  tests = gets.to_i # approx. 2000

  tests.times do |i|
    k, l = gets.chomp.split(' ').map { |i| i.to_i }
    keys = gets.chomp
    letters = gets.chomp
    frequencies = []
    letters.size.times { frequencies << gets.chomp.to_i }

    puts "Keypad ##{i+1}:"
    SPOJ::IKeyboard.solve( keys, letters, frequencies )
    puts
  end

end

