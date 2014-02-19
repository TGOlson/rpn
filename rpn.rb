OPERATIONS = ['+', '-', '/', '*']

NUMBER_MAPPINGS = {
  '0' => 0,
  '1' => 1,
  '2' => 2,
  '3' => 3,
  '4' => 4,
  '5' => 5,
  '6' => 6,
  '7' => 7,
  '8' => 8,
  '9' => 9,
}

class RPNCalculator

  def self.evaluate(statement)
    raise ArgumentError, 'Not enough arguments.' unless statement.split.length >= 3
    output = []

    statement.split.each do |item|
      if OPERATIONS.include?(item)
        item = perform_operation(output.pop(2), item)
      end
      output << to_i(item)
    end

    output.first
  end

  def self.to_i(string)
    return string if string.is_a? Integer
    number   = 0
    negative = false

    if string[0] == '-'
      negative = true
      string.slice!(0)
    end

    magnitude = string.length - 1

    string.length.times do |i|
      number += map_current_char(string[i], magnitude - i)
    end

    negative ? number * -1 : number
  end

  private

  def self.perform_operation(numbers, operation)
    raise StandardError, 'Illegal RPN format' unless numbers.length == 2
    numbers.first.send(operation, numbers.last)
  end

  def self.map_current_char(char, order)
    digit = NUMBER_MAPPINGS[char]
    raise ArgumentError, 'Invalid number.' if digit.nil?
    digit * 10 ** order
  end
end

# This allows program to accept command line arguments, if present
# If no arguments are present, either the user messed up or the specs are being run
p RPNCalculator.evaluate(ARGV.first) unless ARGV.empty?
