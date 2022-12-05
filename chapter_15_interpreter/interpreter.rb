# frozen_string_literal: true

require 'find'

class Expression
end

# AST的终点
class Bigger < Expression

end

# AST的终点
class Writable < Expression

end

# AST的终点
class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []
    Find.find(dir) do |path|
      # 如果不是文件就跳过
      next unless File.file?(path)
      name = File.basename(path)
      results << path if File.fnmatch(@pattern, name)
    end
    results
  end
end

class All < Expression
  def evaluate(dir)
    results = []
    Find.find(dir) do |path|
      # 如果不是文件就跳过
      next unless File.file?(path)

      results << path
    end
    results
  end
end

all = All.new
result = all.evaluate('C:\\Users\\kuanghc1\\Downloads\\v2rayn')
puts(result)

expr_dll = FileName.new('*.dll')
dlls = expr_dll.evaluate('C:\\Users\\kuanghc1\\Downloads\\v2rayn')
dlls.each { |name| puts("file is #{name}") }

class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

class Or < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    result1 || result2
  end
end

class And < Expression
  def initialize(expression1, expression2)
    @expression1 = expression1
    @expression2 = expression2
  end

  def evaluate(dir)
    result1 = @expression1.evaluate(dir)
    result2 = @expression2.evaluate(dir)
    result1 && result2
  end
end

# 当有了Not，And，Or和节点之后
# And.new(And.new(ExpressonTwo.new, ExpressonThree.new), Not.new(ExpressonOne.new))

not_dlls = Not.new(FileName.new('*.dll'))
not_dlls_evaluate = not_dlls.evaluate('C:\\Users\\kuanghc1\\Downloads\\v2rayn')
not_dlls_evaluate.each { |file| puts("not dll file is #{file}") }
