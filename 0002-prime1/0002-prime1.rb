#!/usr/bin/ruby

# Finds all prime numbers up to 'n'
# using eratosthenes sieve method
def eratosthenes(n)
  # starting from '0' will avoid extra calculation to find correct index
  sieve = (0..n).to_a
  sieve[0] = sieve[1] = nil

  sieve.each do |s|
    next unless s
    square_s = s*s
    break if square_s > n

    square_s.step(n, s) do |non_prime|
      sieve[non_prime] = nil
    end
  end
  sieve.compact
end

# Uses eratosthenes sieve method to find
# all prime numbers between 'x' and 'y'
def primes_between( x, y )
  return [] if y < 2
  x = 2 if (x == 1)

  possible_primes = (x..y).to_a
  range_size = y - x + 1
  sqrt_primes = eratosthenes Math.sqrt(y).to_i
  sqrt_primes.inspect

  # Set to nil each multiple of 'prime'
  sqrt_primes.each do |prime|
    min = 0 # min will assure that you skip 'prime' itself
    min += 1 if x <= prime
    first_index = ( ( (x.to_f / prime).ceil + min) * prime ) - x

    first_index.step(range_size, prime) do |non_prime|
      possible_primes[non_prime] = nil
    end
  end

  possible_primes.compact
end

# Find all prime numbers in test cases
if __FILE__ == $0
  while tests = gets

    tests.to_i.times do |i|
      line = gets
      n1,n2 = line.split(' ').map { |n| n.to_i }
      primes_between(n1, n2).each { |p| print "#{p}\n" }
      print "\n"
    end

    break

  end
end
