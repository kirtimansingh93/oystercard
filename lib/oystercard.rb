class Oystercard
  attr_reader :balance
  MAX = 90
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "#{Oystercard::MAX} limit reached" if @balance + amount > MAX
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end
