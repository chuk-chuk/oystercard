class Journey

  MIN_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
    @complete = false
    @fare = 0
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    @complete = true if !!@entry_station
  end

  def fare
    @fare = complete? ? MIN_FARE : PENALTY_FARE
  end

  def in_journey?
    !!@entry_station and @complete == false
  end

  def complete?
    @complete
  end

end
