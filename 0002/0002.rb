#!/usr/bin/ruby

# Finds all prime numbers up to Math.sqrt(y)
# using eratosthenes sieve method recursively
def eratosthenes(y)
  return [] if y == 1
  all_primes = eratosthenes(Math.sqrt(y).to_i)

  primes = (2..y).to_a
  primes_size = primes.size
  bools = []
  primes_size.times { bools << true }
  max_search = Math.sqrt(y).ceil

  # Handles basic case: 2 as a prime and its multiples as non-prime
  n = 0
  if (primes[n]%2 == 0)
    if (primes[n] == 2)
      n += 2
    end
  else
    n += 1
  end
  while ( n < primes_size ) do
    bools[n] = false
    n += 2
  end

  # Try to divide all numbers by all prime numbers up to max_search
  all_primes.each do |i|
    n = 0
    while (n < primes_size) do
      if bools[n]
        if (primes[n]%i == 0) and (primes[n] != i)
          while (n < primes_size) do
            bools[n] = false
            n += i
          end
          break
        end
      end

      n += 1
    end
  end

  # List numbers not marked as non-prime
  p = 0
  primes_found = []
  while (p < primes_size) do
    primes_found << primes[p] if bools[p]

    p += 1
  end

  primes_found
end

# Uses eratosthenes sieve method to find all prime
# numbers between interval x and y
def primes_between( x, y )
  x = 2 if x == 1
  max = Math.sqrt(y).to_i
  max_primes = eratosthenes max
  max_primes_size = max_primes.size
  numbers = (x..y).to_a
  numbers_size = numbers.size
  bools = Array.new numbers_size, true

  # Compare each prime with all the numbers
  max_primes.each do |p|
    n = 0
    while (n < numbers_size) do
      if (numbers[n]%p == 0)
        n += p if (numbers[n] == p)
        while (n < numbers_size) do
          bools[n] = false
          n += p
        end
        break
      end
      n += 1
    end
  end

# Compare each number with all the primes
=begin
  num = 0
  num = 1 if numbers[0]%2 == 0
  while (num < numbers_size) do
    p = 0
    while (p < max_primes_size) do
      if (numbers[num]%max_primes[p] == 0)
        i = num
        i += max_primes[p] if numbers[num] == max_primes[p]
        while (i < numbers_size) do
          bools[i] = false
          i += max_primes[p]
        end
        max_primes.delete_at p
        max_primes_size -= 1
      end
      p += 1
    end
    num += 2
  end
=end


  # List numbers not marked as non-prime
  p = 0
  primes_found = []
  p += 1 if numbers[p] == 1
  if numbers[p] == 2
    primes_found << 2
    p += 1
  end
  while (p < numbers_size) do
    primes_found << numbers[p] if bools[p]
    p += 2
  end
  primes_found
end

# Find all prime numbers in test cases
while tests = gets

  tests.to_i.times do |i|
    line = gets
    n1,n2 = line.split(' ').map { |n| n.to_i }
    puts primes_between(n1, n2).inspect
  end

  break

end

#puts eratosthenes( 120 ).inspect
#puts eratosthenes( Math.sqrt(1000000000).to_i ).inspect
#puts primes_between(1,120).inspect
#puts primes_between(999900000, 1000000000).inspect
