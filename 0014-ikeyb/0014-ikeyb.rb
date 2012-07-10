#!/usr/bin/ruby

module SPOJ

  class IKeyboard

    MAX_KEYS = 90
    MAX_LETTERS = 90
    INFINITE = 100000 * (MAX_LETTERS+1)*MAX_LETTERS/2 # max price of a solution (all letters in a single key)

    # Having these as class variables saves precious time when dealing with several thousand cases
    SOLUTION   = Array.new(MAX_KEYS) { Array.new(MAX_LETTERS) { 0 } } # Best letter with which to start key _k_ if using _l_ letters
    BEST_PRICE = Array.new(MAX_KEYS) { Array.new(MAX_LETTERS) { INFINITE } } # best price for SOLUTION with _k_ keys and _l_ letters

    def self.solve(num_keys, num_letters, frequencies)
      # Initialize best price matrix for problem
      k = l = 0
      while k < num_keys-1
        while l < num_letters-1
          BEST_PRICE[k][l] = INFINITE
          l += 1
        end
        k += 1
      end

      BEST_PRICE[0][-1] = 0 # minimize comparisons when initializing
      k = -1
      while k < num_keys-1 # using ranges or Fixnum#times is just too slow when dealing with this many cases
        k += 1
        current_price = 0
        l = k-1
        while l < num_letters-1
          l += 1
          # Initializing first key costs: all letters in a single key
          if k == 0
            BEST_PRICE[k][l] = BEST_PRICE[k][l-1] + frequencies[l] * (l+1) # current_price
            next
          end

          # Assume BEST_PRICE[k-1][l-1] is the best solution so far and compare it
          # with all possible solutions with more letters on the next key.
          # e.g.: suppose BEST_PRICE[k-1][l-1] = a, then try
          #       a, b
          #       a, bc
          #       a, bcd
          #       a, bcde
          #       ...
          current_price = 0
          j = l-1
          while j < num_letters-1
            j += 1
            current_price += frequencies[j] * (j-l+1)
            possible_solution = BEST_PRICE[k-1][l-1] + current_price
            if possible_solution < BEST_PRICE[k][j]
              BEST_PRICE[k][j] = possible_solution
              SOLUTION[k][j] = l
            end
          end

        end

      end

    end

    # SOLUTION[key][letter] contains the first char that should be printed for a problem with
    # _key_ keys and _letter_ letters. So from a given _k_ and _l_ we can backtrack to the first
    # key and print all characters for all keys.
    def self.print_solution(keys, letters, last_key, last_letter)
      return if last_key < 0
      initial_char = SOLUTION[last_key][last_letter]
      self.print_solution keys, letters, last_key-1, initial_char-1
      puts keys[last_key] + ": " + letters[initial_char..last_letter]
    end

  end

end


if __FILE__ == $0
  tests = gets.to_i # approx. 2000

  i = 0
  while i < tests
    i += 1
    num_keys, num_letters = gets.split(' ').map { |n| n.to_i }
    keys = gets.chomp
    letters = gets.chomp
    frequencies = Array.new(num_letters) { gets.to_i }

    puts "Keypad ##{i}:"
    SPOJ::IKeyboard.solve( num_keys, num_letters, frequencies )
    SPOJ::IKeyboard.print_solution keys, letters, num_keys-1, num_letters-1
    puts
  end

end

