# frozen_string_literal: true

class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

array = [1,3,5,7,9]

iterator = ArrayIterator.new(array)
while iterator.has_next?
  puts("item is #{iterator.next_item}")
end