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

# Decorator做包装
class WriterDecorator
  def initialize(writer)
    @writer = writer
  end

  def write_line(line)
    @writer.write_line(line)
  end

  def pos
    @writer.pos
  end

  def rewind
    @writer.rewind
  end

  def close
    @writer.close
  end
end

class NumberingWriter < WriterDecorator
  def initialize(writer)
    super(writer)
    @line_number = 1
  end

  def write_line(line)
    @writer.write_line("#{@line_number} : #{line}")
    @line_number += 1
  end
end

class TimeStampingWriter < WriterDecorator
  def initialize(writer)
    super(writer)
  end

  def write_line(line)
    @writer.write_line("#{Time.new} : #{line}")
  end
end

writer = TimeStampingWriter.new(NumberingWriter.new(SimpleWriter.new('final.txt')))
writer.write_line('Hello out there')
writer.write_line('Hello out here')
writer.write_line('Hello out where')
