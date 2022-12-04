# frozen_string_literal: true

class VariableTester
  # 类变量
  @@class_count = 0

  def initialize
    @instance_count = 0
  end

  def increment
    @@class_count += 1
    @instance_count += 1
  end

  def to_s
    "#{@@class_count} #{@instance_count}"
  end
end

c1 = VariableTester.new
c1.increment
c1.increment
puts(c1)

c2 = VariableTester.new
c2.increment
c2.increment
puts(c2)

c3 = VariableTester.new
c3.increment

require 'singleton'

class HelloWorld
  include Singleton

  def instance_method
    puts self
    puts 'instance method'
  end
end

puts HelloWorld.instance
puts HelloWorld.instance.instance_method
