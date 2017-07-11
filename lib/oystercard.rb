require_relative 'journey'
require_relative 'journey_log'
require_relative 'station'

class Oystercard

  attr_reader :balance, :entry_station, :history, :journey

  DEFAULT_BALANCE = 0
  PENALTY_FARE = 6
  MIN_BALANCE = PENALTY_FARE
  MIN_FARE = 1
  LIMIT = 90

  def initialize(balance = DEFAULT_BALANCE, journey_log = JourneyLog.new(Journey))
    @balance = balance
    @journey_log = journey_log
  end

  def top_up(topup_value)
    raise "Sorry, the maximum amount is £#{LIMIT}" if exceeded?(topup_value)
     @balance += topup_value
  end

  def touch_in(station)
    raise "Touch in failed, balance lower than minimum" if balance < MIN_FARE
    @journey_log.start(Station.new(station))
  end

  def touch_out(station)
    @journey_log.finish(Station.new(station))
    deduct(@journey_log.journeys.last.fare)
  end

  def in_journey?
    @journey_log.in_journey?
  end

  private

  def exceeded?(topup_value)
    @balance + topup_value > LIMIT
  end

  def deduct(spent_fare)
    @balance -= spent_fare
  end

end
