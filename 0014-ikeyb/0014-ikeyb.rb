#!/usr/bin/ruby

module SPOJ

  class IKeyboard

    def self.solve(keys, letters, frequencies)
      num_keys = keys.size
      num_letters = letters.size
      price = Array.new(num_keys) { Array.new }
      solution = Array.new(num_keys) { Array.new }

      num_keys.times do |k|
        current_price = 0

        num_letters.times do |l|
          # initialize
          if k == 0
            current_price += frequencies[l] * (l+1)
            price[k][l] = current_price
            solution[k][l] = 0
          end
        end
      end
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

