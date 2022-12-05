# frozen_string_literal: true
class Duck
  def initialize(name)
    @name = name
  end

  def eat
    puts "Duck #{@name} eats something"
  end

  def speak
    puts "Duck #{@name} speaks"
  end

  def sleep
    puts "Duck #{@name} sleeps"
  end
end

class Frog
  def initialize(name)
    @name = name
  end

  def eat
    puts "Frog #{@name} eats something"
  end

  def speak
    puts "Frog #{@name} speaks"
  end

  def sleep
    puts "Frog #{@name} sleeps"
  end
end

class Pond
  def initialize(number_animals)
    @animals = []
    number_animals.times do |i|
      duck = new_animal("Animal #{i}")
      @animals << duck
    end
  end

  def simulate_one_day
    @animals.each { |animal| animal.speak }
    @animals.each { |animal| animal.eat }
    @animals.each { |animal| animal.sleep }
  end
end

class DuckPond < Pond
  def new_animal(name)
    Duck.new(name)
  end
end

class FrogPond < Pond
  def new_animal(name)
    Frog.new(name)
  end
end

pond = FrogPond.new(3)
pond.simulate_one_day
