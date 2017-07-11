class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :history

  DEFAULT_BALANCE = 0
  MIN_FARE = 1
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @entry_station = nil
    @history = []
  end

  def top_up(topup_value)
    raise "Sorry, the maximum amount is £#{LIMIT}" if exceeded?(topup_value)
     @balance += topup_value
  end

  def in_journey?
    entry_station != nil
  end

  def touch_in(station)
    raise "Touch in failed, balance lower than minimum" if balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
    history << { entry_st: entry_station, exit_st: station }
    @entry_station = nil
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end

  def deduct(spent_fare)
    @balance -= spent_fare
  end

end
