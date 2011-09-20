#!/usr/bin/ruby

module SPOJ

  class SimpleArithmetics

    def self.pretty_print(expression)
      print expression
    end

  end

end




if __FILE__ == $O

  tests = gets.to_i # tests <= 1000

  tests.times do |i|
    expression = gets.rstrip

    SPOJ::SimpleArithmetics.pretty_print expression
    print "\n"
  end

end

