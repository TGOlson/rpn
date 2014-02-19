require_relative 'spec_helper'

assert_thrown 'it returns an error if not enough arguments' do
  RPNCalculator.evaluate('1 +')
end

assert 'it can handle a simple addition statement' do
  RPNCalculator.evaluate('1 2 +') == 3
end

assert 'it can handle other operations' do
  RPNCalculator.evaluate('5 2 -') == 3
  RPNCalculator.evaluate('5 2 *') == 10
end

assert 'it can handle multiple operations' do
  RPNCalculator.evaluate('2 3 4 + *') == 14
end

assert 'it can handle multiple operations and nested numbers' do
  RPNCalculator.evaluate('3 4 + 5 6 + *') == 77
end

assert_thrown 'it returns an error for invalid arguments' do
  RPNCalculator.evaluate('a b +')
end

assert_thrown 'it returns an error for illegal RPN formatting' do
  RPNCalculator.evaluate('1 + 4')
end
