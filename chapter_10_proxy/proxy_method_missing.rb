# frozen_string_literal: true

class TestMethodMissing
  def hello
    puts("hello from a real world")
  end

  private def method_missing(symbol, *args)
    puts("not found #{symbol}")
    puts("args #{args.join(' ')}")
  end
end

# test = TestMethodMissing.new
# test.hello
# test.world("one", 2)
#
# test.send(:hello)
# test.send(:goodbye, 'cruel', 'world')

class BankAccount
  attr_reader :balance

  def initialize(starting_balance = 0)
    @balance = starting_balance
  end

  def deposit(amount)
    @balance += amount
  end

  def withdraw(amount)
    @balance -= amount
  end
end

class AccountProxy
  def initialize(real_account)
    @subject = real_account
  end

  # 使用method_missing方法去调用
  def method_missing(symbol, *args)
    puts("Delegating #{symbol} message to subject")
    @subject.send(symbol, *args)
  end
end

accountProxy = AccountProxy.new(BankAccount.new)
accountProxy.deposit(25)
accountProxy.withdraw(50)
puts("account balance is now: #{accountProxy.balance}")