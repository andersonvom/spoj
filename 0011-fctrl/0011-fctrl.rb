#!/usr/bin/ruby

module SPOJ

  class Factorial

    # For educational/testing purposes only
    # Calculates the factorial of _n_
    # e.g.: fact(5) # => 5 * 4 * 3 * 2 * 1 # => 120
    def self.fact(n)
      factorial = 1
      (2..n).each do |i|
        factorial *= i
      end
      factorial
    end

    def self.z(n)
    end

  end

end


if __FILE__ == $0
  tests = gets.to_i # approx. 100000

  tests.times do |i|
    n = gets.to_i
    puts SPOJ::Factorial.z(n)
  end

end

