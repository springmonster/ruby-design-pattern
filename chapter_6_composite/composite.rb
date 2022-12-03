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

class CompositeTask < Task
  def initialize(name)
    super(name)
    @tasks = []
  end

  def add_task(task)
    @tasks << task
  end

  def remove_task(task)
    @tasks.delete(task)
  end

  def get_time_required
    time = 0.0
    @tasks.each { |task| time += task.get_time_required }
    time
  end
end

class CombinedTask < CompositeTask
  def initialize
    super('CombinedTask')
    add_task(TaskOne.new)
    add_task(TaskTwo.new)
  end
end

combinedTask = CombinedTask.new
puts("CombindedTask total time is #{combinedTask.get_time_required}")
