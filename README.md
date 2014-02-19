# Reverse Polish Notation Calculator

by [Tyler Olson](http://tgolson.com)

Calculates statements given in [reverse polish notation format](http://en.wikipedia.org/wiki/Reverse_Polish_notation).

Written using Ruby version 2.0.0p353

## Features

* Evaluates statements in RPN format.
* Multiple error checks (illegal characters, format, etc.).
* Does not accept decimals in statements.
* Full testing on all included methods.
* Works with negative numbers and statements that evaluate to negative.

## Examples of RPN format:

From [Wikipedia](http://en.wikipedia.org/wiki/Reverse_Polish_notation)

> Reverse Polish notation (RPN) is a mathematical notation in which every operator follows all of its operands...

```
'1 2 +' = 3
'4 2 /'' = 2
'2 3 4 + *' = 14
'3 4 + 5 6 + *' = 77
'13 4 -' = 9
```

## How to Run

Run the program by passing in RPN statements in string format via the command line.

```
$ ruby rpn.rb '4 2 /'
=> 2

$ ruby rpn.rb '2 3 4 + *'
=> 14
```

## Error Checking

The program checks for errors at multiple points.

**Number of Arguments**

The program needs at least three elements in the input string to run (two numbers and an operation). The program will throw an error if the statement passed in contains less than three elements.

```
$ ruby rpn.rb  '1 +'
=> rpn.rb:19:in `evaluate': Not enough arguments. (ArgumentError)
```

**Invalid Numbers**

Passing in invalid numbers (for example, letters or decimals) will produce an error for illegal characters. This error is produced while mapping string characters to numbers, and so it is run as an independent check on each character.

```
$ ruby rpn.rb  'a b +'
=> rpn.rb:57:in `map_current_char': Invalid number. (ArgumentError)

$ ruby rpn.rb  '2 3.0 +'
=> rpn.rb:57:in `map_current_char': Invalid number. (ArgumentError)
```
**Illegal RPN Format**

Lastly, the program will produce a general error for illegal RPN formats. For example, an operator that is not preceded by two numbers.

```
$ ruby rpn.rb '1 + 4'
=> rpn.rb:33:in `perform_operation': Illegal RPN format (StandardError)
```

## Methods

All methods are class methods of the ```RPNCalculator``` class.

```::evaluate(statement)``` Takes in an RPN formatted statement and returns a solution. This is called to evaluate statements that are passed in via the command line. Produces an error if the statement passed in does not contain enough arguments.

```::to_i(string)``` Converts a given string to an integer. Only works for positive or negative integer strings, and returns the same integer if an integer is passed in.

**Private Methods**

These methods are used to helper the two main methods, listed above.

```::perform_operation(numbers, operation)``` This is a helper method to ```evaluate```, which takes in two numbers and an operation, and returns the evaluation of the numbers and operation. It raises an error unless there is exactly two numbers present.

```::map_current_char(char, order)``` This is a helper method to ```to_i```, which takes in a character to map to a digit, as well as the current order of magnitude for the digit. It returns a digit, and raises an error if the character passed in is not a single digit in string format.

## Tests

All methods included in this program were written using test driven development using custom ```assert``` and ```assert_thrown``` statements as the test framework. This is a small program, so the custom test methods were chosen in liue of a larger test framework, such as ```RSpec```.

```assert``` statements are used to test the expected output of a method:

```ruby
assert 'it can handle a number less than ten' do
  RPNCalculator.to_i('1') == 1
end
```

```assert_thrown``` statements are used if an error is expected to be raised:

```ruby
assert_thrown 'it returns an error for decimals' do
  RPNCalculator.to_i('12.0')
end
```

Tests can be run from the command line. If no ```AssertionErrors``` are thrown, all the tests have passed.

```
$ ruby spec/evaluate_spec.rb
```
```
$ ruby spec/to_i_spec.rb
```