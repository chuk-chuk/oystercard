class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(topup_value)
    raise "Sorry, the maximum amount is £#{LIMIT}" if exceeded?(topup_value)
     @balance += topup_value
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end
end
