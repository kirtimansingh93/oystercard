class Oystercard
  attr_reader :balance, :in_journey
  MAX = 90
  def initialize
    @balance = 0
    @in_journey = false

  end

  def top_up(amount)
    raise "Maximum limit of #{Oystercard::MAX} pounds" if @balance + amount > MAX
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out
    @in_journey = false
    true
  end
end
