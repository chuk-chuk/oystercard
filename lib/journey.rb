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
    fare
  end

  def finish(station)
    @exit_station = station
    @complete = true if !!@entry_station
    fare
  end

  def fare
    @fare = if complete?
      MIN_FARE + (entry_station.zone - exit_station.zone).abs
    else
      PENALTY_FARE
    end
  end

  def in_journey?
    !!@entry_station and @complete == false
  end

  def complete?
    @complete
  end

end
