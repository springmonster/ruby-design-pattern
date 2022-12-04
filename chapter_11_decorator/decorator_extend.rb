# frozen_string_literal: true

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print(line)
    @file.print("\n")
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

# 方法1
# 通过alias
w = SimpleWriter.new('out')

# 扩展SimpleWriter的实例，将write_line方法声明为alias的形式
class << w
  alias old_write_line write_line

  def write_line(line)
    old_write_line("#{Time.new}: #{line}")
  end
end

w.write_line('this is test content')

# 方法2
# 通过extend
module TimeStampingWriter
  def write_line(line)
    super("#{Time.new}: #{line}")
  end
end

module NumberingWriter
  attr_reader :line_number

  def write_line(line)
    @line_number = 1 unless @line_number
    super("#{@line_number}: #{line}")
    @line_number += 1
  end
end

# extend的本质是：将extend的class插入到对象之前，最先插入的最先调用
w1 = SimpleWriter.new('out_1')
w1.extend(TimeStampingWriter)
w1.extend(NumberingWriter)
w1.write_line('this is extend testing')