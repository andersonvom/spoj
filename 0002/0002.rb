#!/usr/bin/ruby

def is_prime(x)
  # Previously optimized
  # return false if x == 1
  # return true  if x == 2

  # Optimize first well known primes
  return true if [3,5,7,11,13,17,19].include? x

  # It is known that if no dividers are found up to sqrt(x), then x is prime
  max = Math.sqrt x

  # Find out whether x is indeed a prime
  (2..max).each do |i|
    return false if x%i == 0
  end

  true
end


while tests = gets

  tests.to_i.times do |i|
    
    line = gets
    n1,n2 = line.split(' ').map { |n| n.to_i }

    # Even numbers are not prime, except for 2
    n1 += 1 if ( n1%2 == 0 ) and ( n1 != 2 )
    n2 -= 1 if ( n2%2 == 0 ) and ( n2 != 2 )

    # Handle basic cases: 1 and 2
    n = n1
    n += 1 if n == 1
    if n == 2
      puts n
      n += 1
    end

    while ( n <= n2 )
      puts n if is_prime n
      n += 2
    end
    puts

  end

end
