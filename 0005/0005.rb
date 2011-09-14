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
# of 'n' and incrementally increasing values on the first half
# if necessary and duplicating them on the second half
def next_palindrome(n)
  n    = n.to_s
  size = n.size

  # Handle small cases (0..10) to optimize speed
  if size == 1
    return (n[0].ord + 1).chr if n < "9"
    return "11"
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
    n[middle] = ( (n[middle].chr.to_i + 1) % 10).to_s
    inc = false unless n[middle].chr == "0"
  end

  # Duplicate first half on the other, increasing each number if necessary
  (first+1).times do |i|
    f_idx = first-i
    l_idx = last+i
    if inc
      n[f_idx] = ( (n[f_idx].chr.to_i + 1) % 10 ).to_s
      inc = false unless n[f_idx].chr == "0"
    end
    n[l_idx] = n[f_idx]
  end

  # If still needs to be increased, it's because first digit became 10
  # In this case, add 1 to the beginning and the end of the string
  if inc
    n[-1] = "1"
    n = "1#{n}"
  end
  n
end


# Run all test cases
if __FILE__ == $0
  while tests = gets
    tests = tests.to_i # Unknown max value

    tests.times do |i|
      num = gets # 1000000- characters
      print next_palindrome num
      print "\n"
    end

    break

  end
end
