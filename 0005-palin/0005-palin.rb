#!/usr/bin/ruby

# Returns true if n is a palindrome and false otherwise
def is_palindrome(n)
  s = n.to_s
  half = (s.size / 2.0).ceil - 1

  n = 0
  while (n <= half)
    back = (n+1) * -1
    return false if s[n] != s[back]
    n += 1
  end

  true
end

# Returns the first number after 'n' that is a palindrome
def next_palindrome_brute(n)
  while true
    n += 1
    return n.to_s if is_palindrome(n)
  end
end

# Generates next palindrome after n by analyzing both halves
# of 'n' and increasing values on the first half if necessary
def next_palindrome(n)
  n    = n.to_s
  size = n.size

  # Handle small cases (0..10) to optimize speed
  if size == 1
    n = n.succ[-1]
    n = "11" if n == "0"
    print n
    return
  end

  even_size = size % 2
  half      = size / 2
  first     = half - 1
  middle    = half unless even_size == 0
  last      = half + even_size

  # Detect whether the first half needs to be increased or not
  inc = true
  (first+1).times do |i|
    f = n[first-i]
    l = n[last+i]
    next if f == l
    inc = false if f > l
    break
  end

  # If it needs to be increased, handle middle number if necessary
  # If middle number ends up higher then 9, reset and keep increasing
  if inc and middle
    n[middle] = n[middle].succ[-1]
    inc = false unless n[middle] == "0"
  end

  # Increase first half if necessary
  init = 0
  if inc
    temp = n[0..first].succ
    n[0..first] = temp
    # If first half increased in size, adjust indexes
    unless temp.size == first+1
      first += 1
      init = 2 # save space for second half
    else
      inc = false
    end
  end

  print n[0..first]
  print n[middle] if middle
  print n[init..first].reverse
  print 1 if inc # print new digit (reversed)
end

# Run all test cases
if __FILE__ == $0
  while tests = gets
    tests = tests.to_i # Unknown max value

    tests.times do |i|
      num = gets # 1000000- characters
      num.rstrip!
      next_palindrome num
      print "\n"
    end

    break

  end
end
