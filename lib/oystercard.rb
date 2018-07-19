class Oystercard
  attr_reader :balance, :entry_station, :exit_station
  MAX = 90
  MIN = 1
  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Maximum limit of #{MAX} pounds" if @balance + amount > MAX
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(entry_station)
    raise "balance below minimum" if @balance < MIN
    @entry_station = entry_station
    @in_journey = true
  end

  def in_journey?
    @in_journey
  end

  def touch_out(exit_station)
    @balance -= MIN
    @in_journey = false
    @entry_station = nil
    @exit_station = exit_station
    true
  end
end
