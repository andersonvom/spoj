#!/usr/bin/ruby

# Reverse Polish notation (RPN) is a mathematical notation wherein
# every operator follows all of its operands.
# http://en.wikipedia.org/wiki/Reverse_Polish_notation
# Examples:
#   (a + b)   --> "ab+"
#   (a+(b*c)) --> abc*+
def rpn( exp )
  a  = [] # operands stack
  op = [] # operator stack

  exp.each_char do |c|
    next if c == '(' # discard opening brackets

    # When closing brackets, execute last operation and push result back to stack
    if c == ')'
      aux = a.pop
      a1 = "#{a.pop}#{aux}#{op.pop}"
      a << a1

    # Push operators to stack
    elsif (c == '^') or (c == '/') or (c == '*') or (c == '-') or (c == '+')
      op << c

    # Everything else is an operand. Push them to the stack
    else
      a << c
    end

  end

  a.pop
end

# Run all test cases
if __FILE__ == $0
  while expressions = gets
    expressions = expressions.to_i # 100- expressions

    expressions.times do |i|
      exp = gets.strip # 400- characters
      print rpn exp
      print "\n"
    end

    break

  end
end

