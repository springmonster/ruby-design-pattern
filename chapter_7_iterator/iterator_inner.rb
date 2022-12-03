# frozen_string_literal: true

# 非常典型的block
def for_each_element(array, &block)
  array.each(&block)
end

a = [10, 20, 30, 40]

for_each_element(a) { |e| puts("The element is #{e}") }
