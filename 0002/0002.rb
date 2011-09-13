#!/usr/bin/ruby


def sieve_to(n)
  sieve = (2..n).to_a

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


# Finds all prime numbers up to Math.sqrt(x)
# using eratosthenes sieve method recursively
def eratosthenes(x)
  return [] if x <= 1
  return [2] if x == 2

  all_primes = eratosthenes(Math.sqrt(x).to_i)
  bools = Array.new x+1, true

  # Try to divide all numbers by all prime numbers up to 'x'
  all_primes.each do |p|
    n = 3
    while (n <= x) do
     if (n%p == 0) and (n != p)
        while (n <= x) do
          bools[n] = false
          n += p
        end
        break
      end

      n += 2
    end
  end

  # List numbers not marked as non-prime
  p = 3
  primes_found = []
  primes_found << 2 if x >= 2
  while (p <= x) do
    primes_found << (p) if bools[p]
    p += 2
  end

  primes_found
end

# Uses eratosthenes sieve method to find all prime
# numbers between interval x and y
def primes_between( x, y )
  return if y < 2
  range_size = y - x + 1

  bools = Array.new range_size, true
  sqrt_primes = eratosthenes Math.sqrt(y).to_i

  # Choose where to start looking for primes, ignoring even numbers
  min_number = 0
  min_number += 2 if (x == 1)
  min_number += 1 if (x%2 == 0)

  sqrt_primes.each do |p|
    n = min_number
    while (n < range_size) do
        probable_prime = x + n
        if (probable_prime%p == 0)
          n += p if (probable_prime == p)
          while (n < range_size) do
            bools[n] = false
            n += p
          end
          break
        end
      n += 2
    end
  end

  # List numbers not marked as non-prime, skipping even numbers
  n = min_number
  print "2\n" if (x <= 2) and (y >= 2)
  while (n < range_size) do
    print "#{(x + n)}\n" if bools[n]
    n += 2
  end
end

# Find all prime numbers in test cases
if __FILE__ == $0
  while tests = gets

    tests.to_i.times do |i|
      line = gets
      n1,n2 = line.split(' ').map { |n| n.to_i }
      primes_between(n1, n2)
      print "\n"
    end

    break

  end
end


