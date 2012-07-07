#!/usr/bin/ruby

module SPOJ

  class IKeyboard

    def self.solve(keys, letters, frequencies)
      num_keys = keys.size
      num_letters = letters.size
      cost = Array.new(num_letters) { Array.new }
      best_price = Array.new(num_keys) { Array.new }
      solution = Array.new(num_keys) { Array.new } # Best letter with which to start key _k_ if using _l_ letters

      # Initialize costs:
      # This is a triangular matrix with the accumulated costs of each letter and its successors
      # e.g.: a, ab, abc, abcd, abcde, ...
      #           b,  bc,  bcd,  bcde, ...
      #                c,   cd,   cde, ...
      #                      d,    de, ...
      #                             e, ...
      num_letters.times do |i|
        (i..num_letters-1).each do |j|
          prev_idx = (j > 0) ? j-1 : j
          cost[i][j] = cost[i][prev_idx].to_i + frequencies[j] * (j-i+1)
          if i == 0 # trivial solution with a single key: all letters go there
            best_price[i][j] = cost[i][j]
            solution[i][j] = 0
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

