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


def next_palindrome(n)
  n = n.to_s
  size = n.size
  even_size = size % 2
  half = (size / 2)

  # Handle small cases (0..10) to optimize speed
  if size == 1
    n = n.to_i
    return (n+1).to_s if n < 9
    return "11"
  end

  # Handle special case of 9's to avoid complexity
  if n =~ /^9+$/
    n = n.gsub('9', '0')
    n[-1] = '1'
    return "1#{n}"
  end

  next_palindrome = nil
  first = n[0..half-1].to_i
  first_reverse = n[0..half-1].reverse.to_i
  middle = n[half].chr.to_i unless even_size == 0
  last = n[half+even_size..size-1].to_i

  if ( last >= first_reverse )
    if even_size == 0
      first += 1
    else
      middle += 1
      if middle == 10
        middle = 0
        first += 1
      end
    end
  end

  first_reverse = first.to_s.reverse
  #first_reverse = first.to_s.reverse.to_i
  #zero_missing = half - first_reverse.to_s.size
  #append_zero = ""
  #zero_missing.times { |i| append_zero += "0" }
  #first_reverse = "#{append_zero}#{first_reverse}"

  "#{first}#{middle}#{first_reverse}"
end

def np(n)
  n = n.to_s
  size = n.size
  even_size = size % 2
  half = (size / 2)

  # Handle small cases (0..10) to optimize speed
  if size == 1
    n = n.to_i
    return (n+1).to_s if n < 9
    return "11"
  end

  # Handle special case of 9's to avoid complexity
  if n =~ /^9+$/
    n = n.gsub('9', '0')
    n[-1] = '1'
    return "1#{n}"
  end

  next_palindrome = nil
  first = n[0..half-1].to_i
  first_reverse = n[0..half-1].reverse.to_i
  middle = n[half].chr.to_i unless even_size == 0
  last = n[half+even_size..size-1].to_i

  if ( last >= first_reverse )
    if even_size == 0
      first += 1
    else
      middle += 1
      if middle == 10
        middle = 0
        first += 1
      end
    end
  end

  first_reverse = first.to_s.reverse
  #first_reverse = first.to_s.reverse.to_i
  #zero_missing = half - first_reverse.to_s.size
  #append_zero = ""
  #zero_missing.times { |i| append_zero += "0" }
  #first_reverse = "#{append_zero}#{first_reverse}"

  "#{first}#{middle}#{first_reverse}"
end


# Run all test cases
if __FILE__ == $0
  while tests = gets
    tests = tests.to_i # 100- expressions

    tests.times do |i|
      num = gets # 400- characters
      print next_palindrome num
      print "\n"
    end

    break

  end
end

