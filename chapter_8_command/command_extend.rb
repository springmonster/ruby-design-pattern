# frozen_string_literal: true

class Command
  attr_reader :description

  def initialize(description)
    @description = description
  end

  def execute; end
end

class CreateFile < Command
  def initialize(path, contents)
    super("create file: #{path}")
    @path = path
    @contents = contents
  end

  def execute
    File.open(@path, 'w') do |f|
      f.write(@contents)
      f.close
    end
  end
end

class DeleteFile < Command
  def initialize(path)
    super("delete file: #{path}")
    @path = path
  end

  def execute
    File.delete(@path)
  end
end

class CopyFile < Command
  def initialize(from, to)
    super("copy file: #{from} -> #{to}")
    @from = from
    @to = to
  end

  def execute
    FileUtils.cp(@from, @to)
  end
end

class CompositeCommand < Command
  def initialize
    @commands = []
  end

  def add(command)
    @commands << command
  end

  def execute
    @commands.each do |command|
      command.execute
    end
  end

  def description
    description = ''
    @commands.each do |command|
      description += "#{command.description}\n"
    end
    description
  end
end

cmds = CompositeCommand.new

cmds.add(CreateFile.new('file1.txt', 'hello world\n'))
cmds.add(CopyFile.new('file1.txt', 'file2.txt'))
cmds.add(DeleteFile.new('file1.txt'))

puts(cmds.description)