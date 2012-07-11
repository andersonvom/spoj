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

    # For educational/testing purposes only, calculate the
    # number of zeroes of the actual factorial of _n_
    # e.g.: z_naive(50) # => 12
    def self.z_naive(n)
      temp = 1
      num_zeroes = 0
      (2..n).each do |i|
        temp *= i
        while temp%10 == 0
          temp /= 10  # since factorials grow too big, keep it small so that it won't overflow
          num_zeroes += 1
        end
      end
      num_zeroes
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

