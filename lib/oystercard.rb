require_relative 'journey'

class Oystercard

  attr_reader :balance, :entry_station, :history, :journey

  DEFAULT_BALANCE = 0
  MIN_FARE = 1
  PENALTY_FARE = 6
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

  def touch_in(station)
    raise "Touch in failed, balance lower than minimum" if balance < MIN_FARE
    @journey.start(station)
  end

  def touch_out(station)
    @journey.finish(station)
    deduct(@journey.fare)
    history << @journey
    @journey = Journey.new
  end

  def in_journey?
    @journey.in_journey?
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end

  def deduct(spent_fare)
    @balance -= spent_fare
  end

end
