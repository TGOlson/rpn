require_relative '../rpn'

class AssertionError < StandardError
end

def assert(msg = nil, &block)
  raise AssertionError, msg unless yield
end

def assert_thrown(msg = nil, &block)
  begin
    yield
  rescue
    return true
  end

  raise AssertionError, msg
end
