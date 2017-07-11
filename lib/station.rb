class Station
  STATION_ZONE = { 'Bank' => 1, 'Aldgate' => 1, 'Mile End' => 2, 'Stratford' => 3 }.freeze
  attr_reader :name, :zone

  def initialize(name)
    raise 'Station not found' if STATION_ZONE[name.capitalize].nil?
    @name = name.capitalize
    @zone = STATION_ZONE[name.capitalize]
  end
end
