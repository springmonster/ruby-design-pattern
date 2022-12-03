module Subject
  def initialize
    @observers = []
  end

  # 这里加入的是Block
  def add_observer(&observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      # 如果传入的是block，这里就是call方法
      observer.call(self)
    end
  end
end

class Employee
  include Subject

  attr_reader :name, :address
  attr_reader :salary

  def initialize(name, address, salary)
    super()
    @name = name
    @address = address
    @salary = salary
  end

  def salary=(new_salary)
    @salary = new_salary
    notify_observers
  end
end

fred = Employee.new('Fred', '123 Sesame Street', 100_000)

obs = lambda do |changed_employee|
  puts("check for #{changed_employee.name}")
  puts("salary is #{changed_employee.salary}")
end

fred.add_observer(&obs)

# fred.add_observer do |changed_employee|
#   puts("check for #{changed_employee.name}")
#   puts("salary is #{changed_employee.salary}")
# end

fred.salary = 3000