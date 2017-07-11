require_relative 'journey'

class Oystercard

  attr_reader :balance, :in_journey, :entry_station, :history, :journey

  DEFAULT_BALANCE = 0
  MIN_FARE = 1
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @history = []
    @journey = Journey.new
  end

  def top_up(topup_value)
    raise "Sorry, the maximum amount is £#{LIMIT}" if exceeded?(topup_value)
     @balance += topup_value
  end

  def in_journey?
    @journey.entry_station != nil
  end

  def touch_in(station)
    raise "Touch in failed, balance lower than minimum" if balance < MIN_FARE
    @journey.start(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.finish(station)
    history << @journey
    @journey = Journey.new
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end

  def deduct(spent_fare)
    @balance -= spent_fare
  end

end
