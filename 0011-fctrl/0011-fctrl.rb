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

    # Zeroes only appear when 5 multiplies [2,4,6,8] and
    # extra zeroes appear when powers of 5 multiplies these numbers.
    # e.g.: 2 * 3 * 4 * 5     # => 120 (first zero)
    #       ... *6*7*8*9*10   # => 3628800 (second zero)
    #       ... *11*...*15    # => 1307674368000 (third zero)
    #       ... *16*...*20    # => 2432902008176640000 (fourth zero)
    #       ... *23*...*25    # => 15511210043330985984000000 (fifth zero + one extra, since 25 == 5*5)
    def self.z(n)
      power = 5
      num_zeroes = 0
      while power <= n            # the number of zeroes == number of times 5
        num_zeroes += n/power     # and powers of 5 are in the number's factors
        power *= 5
      end
      num_zeroes
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

