class Oystercard

  attr_reader :balance

  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(topup_value)
     @balance += topup_value
  end

end
