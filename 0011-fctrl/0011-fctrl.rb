#!/usr/bin/ruby

module SPOJ

  class Factorial

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

