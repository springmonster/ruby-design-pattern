# frozen_string_literal: true
class Computer
  attr_accessor :display, :motherboard, :drivers

  def initialize(display = :crt, motherboard = MotherBoard.new, drivers = [])
    @display = display
    @motherboard = motherboard
    @drivers = drivers
  end
end

class CPU
end

class BasicCPU < CPU
end

class TurboCPU < CPU
end

class MotherBoard
  attr_accessor :cpu, :memory_size

  def initialize(cpu = BasicCPU.new, memory_size = 1000)
    @cpu = cpu
    @memory_size = memory_size
  end
end

class Driver
  attr_reader :type # :hard_disk, :cd or :dev
  attr_reader :size
  attr_reader :writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

motherboard = MotherBoard.new(TurboCPU.new, 4000)

drivers = []
drivers << Driver.new(:hard_drive, 200000, true)
drivers << Driver.new(:cd, 760, true)
drivers << Driver.new(:dvd, 4700, false)

# computer = Computer.new(:lcd, motherboard, drivers)
# puts computer

class ComputerBuilder
  def initialize
    @computer = Computer.new
  end

  def turbo(has_turbo_cpu = true)
    @computer.motherboard.cpu = TurboCPU.new if has_turbo_cpu
  end

  def display(display)
    @computer.display = display
  end

  def memory_size(size_in_mb)
    @computer.memory_size = size_in_mb
  end

  def add_cd(writer = false)
    @computer.drivers << Driver.new(:cd, 760, writer)
  end

  def add_dvd(writer = false)
    @computer.drivers << Driver.new(:dvd, 4000, writer)
  end

  def add_hard_disk(size_in_mb)
    @computer.drivers << Driver.new(:hard_disk, size_in_mb, true)
  end
end

builder = ComputerBuilder.new
builder.display(:lcd)
builder.turbo
builder.add_cd(true)
builder.add_dvd
builder.add_hard_disk(100000)

puts builder

