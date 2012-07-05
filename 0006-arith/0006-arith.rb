#!/usr/bin/ruby

module SPOJ

  class SimpleArithmetics
    @@expression_format = /(\d+)([-+*])(\d+)/

    def self.pretty_print(expression)
      num1, operand, num2 = expression.match(@@expression_format).captures

      case operand
      when "+","-"
        result = ( operand == "+" ? num1.to_i + num2.to_i : num1.to_i - num2.to_i )
        line_width = [num2.size+1, result.to_s.size].max
        align_width = [num1.size, line_width].max

        format = "%#{align_width}s"
        puts format % num1
        puts format % "#{operand}#{num2}"
        puts format % ("-"*line_width)

        puts format % result
      when "*"
        result = num1.to_i * num2.to_i
        first_operation = num1.to_i * num2[-1].to_i

        first_line_width = [num2.size+1, first_operation.to_s.size].max
        align_width = [num1.size, result.to_s.size, first_line_width].max
        format = "%#{align_width}s"

        puts format % num1
        puts format % "#{operand}#{num2}"
        puts format % ("-"*first_line_width)

        num1 = num1.to_i
        spaces = 0
        num2.reverse.chars do |i|
          puts format % "#{(num1 * i.to_i)}#{" "*spaces}"
          spaces += 1
        end
        if num2.size > 1
          puts format % ("-"*result.to_s.size)
          puts format % result
        end
      end
    end

  end

end


if __FILE__ == $0
  tests = gets.to_i # tests <= 1000

  tests.times do |i|
    expression = gets

    SPOJ::SimpleArithmetics.pretty_print expression
    puts
  end

end

