class Station

  attr_reader :station_name, :station_zone

  def initialize(name, zone)
    @station_name = name
    @station_zone = zone
  end

end
