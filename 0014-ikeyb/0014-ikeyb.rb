#!/usr/bin/ruby

module SPOJ

  class IKeyboard

    MAX_KEYS = 90
    MAX_LETTERS = 90
    INFINITE = 100000 * (MAX_LETTERS+1)*MAX_LETTERS/2   # max price of a solution (all letters in a single key)

    def self.solve(keys, letters, frequencies)
      num_keys = keys.size
      num_letters = letters.size
      cost = Array.new(num_letters) { Array.new(num_letters) { 0 } }
      best_price = Array.new(num_keys) { Array.new(num_letters) { INFINITE } }
      solution = Array.new(num_keys) { Array.new(num_letters) { 0 } } # Best letter with which to start key _k_ if using _l_ letters

      # Initialize costs:
      # This is a triangular matrix with the accumulated costs of each letter and its successors
      # e.g.: a, ab, abc, abcd, abcde, ...
      #           b,  bc,  bcd,  bcde, ...
      #                c,   cd,   cde, ...
      #                      d,    de, ...
      #                             e, ...
      num_letters.times do |i|
        (i..num_letters-1).each do |j|
          cost[i][j] = cost[i][j-1] + frequencies[j] * (j-i+1)

          if (i == 0 or i == j) and i < num_keys # trivial solution with a single key or the same number of keys and letters
            best_price[i][j] = cost[i][j]
            solution[i][j] = j if i == j
          end
        end
      end

      # The best price for _k_ keys and _l_ letters is the minimum value of the results on column _k-1_
      # (best result for _k-1_ keys and _j_ letters) plus the respective costs of the remaining letters for that result
      # e.g.: For 3 keys and 5 letters, the best price will be the minimum of:
      #       best_price[1][2] + CDE
      #       best_price[1][3] +  DE
      #       best_price[1][4] +   E
      (1..num_keys-1).each do |k|
        (k+1..num_letters-1).each do |l|
          (k-1..l-1).each do |j|
            possible_solution = best_price[k-1][j] + cost[j+1][l]
            if possible_solution < best_price[k][l].to_i
              best_price[k][l] = possible_solution
              solution[k][l] = j+1
            end
          end
        end
      end

      print_solution keys, letters, solution, num_keys-1, num_letters-1
    end

    # solution[key][letter] contains the first char that should be printed for a problem with
    # _key_ keys and _letter_ letters. So from a given _k_ and _l_ we can backtrack to the first
    # key and print all characters for all keys.
    def self.print_solution(keys, letters, solution, key, letter)
      return if key < 0
      initial_char = solution[key][letter]
      self.print_solution keys, letters, solution, key-1, solution[key][letter]-1
      print "#{keys[key]}: "
      (initial_char..letter).each { |l| print letters[l] }
      puts
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

