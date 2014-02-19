require_relative 'spec_helper'

assert 'it can handle an empty string' do
  # nil converts to 0, same as Ruby #to_i method
  RPNCalculator.to_i('') == 0
end

assert 'it can handle a number less than ten' do
  RPNCalculator.to_i('1') == 1
end

assert 'it can handle a number less than 100' do
  RPNCalculator.to_i('67') == 67
end

assert 'it can handle a large number' do
  RPNCalculator.to_i('6234037') == 6234037
end

assert 'it can handle a single digit negative number' do
  RPNCalculator.to_i('-9') == -9
end

assert 'it can handle a large negative number' do
  RPNCalculator.to_i('-1204916191') == -1204916191
end

assert 'it returns the same integer if an integer is passed in' do
  RPNCalculator.to_i(135) == 135
end

assert_thrown 'it returns an error for decimals' do
  RPNCalculator.to_i('12.0')
end

assert_thrown 'it returns an error for other illegal chars' do
  RPNCalculator.to_i('1345aba')
end

assert_thrown 'it should handle a nested negative sign with an error' do
  RPNCalculator.to_i('13-5')
end
