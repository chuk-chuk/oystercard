class Oystercard

  attr_reader :balance, :in_journey

  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(topup_value)
    raise "Sorry, the maximum amount is £#{LIMIT}" if exceeded?(topup_value)
     @balance += topup_value
  end

  def deduct(spent_fare)
    @balance -= spent_fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end
end
