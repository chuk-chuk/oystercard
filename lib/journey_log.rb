require_relative './journey.rb'

class JourneyLog

  def initialize(journey_class=Journey)
    @journeys = []
    @journey_class = journey_class
    @current_journey = nil
  end

  def start(station)
    current_journey.start(station)
  end

  def finish(station)
    current_journey.finish(station)
    @journeys << current_journey
    @current_journey = nil
  end

  def journeys
    @journeys.dup
  end

  private

  def current_journey
    @current_journey ||= @journey_class.new
  end

end
