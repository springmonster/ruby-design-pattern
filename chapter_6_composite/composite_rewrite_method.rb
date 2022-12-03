# frozen_string_literal: true

class Task
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def get_time_required
    0.0
  end
end

class TaskOne < Task
  def initialize
    super('TaskOne')
  end

  def get_time_required
    1.0
  end
end

class TaskTwo < Task
  def initialize
    super('TaskTwo')
  end

  def get_time_required
    2.0
  end
end

class TaskThree < Task
  def initialize
    super('TaskThree')
  end

  def get_time_required
    3.0
  end
end

class CompositeTask < Task
  def initialize(name)
    super(name)
    @tasks = []
  end

  def <<(task)
    @tasks << task
  end

  def remove_task(task)
    @tasks.delete(task)
  end

  def [](index)
    @tasks[index]
  end

  def []=(index, new_value)
    @tasks[index] = new_value
  end

  def get_time_required
    time = 0.0
    @tasks.each { |task| time += task.get_time_required }
    time
  end
end

# class CombinedTask < CompositeTask
#   def initialize
#     super('CombinedTask')
#   end
# end

compositeTask = CompositeTask.new("CompositeTask")
compositeTask << TaskOne.new
compositeTask << TaskTwo.new
puts("Total time is #{compositeTask.get_time_required}")
puts("element[0].get_time_required is #{compositeTask[0].get_time_required}")

compositeTask[2] = TaskThree.new
puts("Total time is #{compositeTask.get_time_required}")

