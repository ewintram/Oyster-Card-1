class Journey

  attr_reader :entry_station, :exit_station, :journey

  PENALTY = 6
  MINIMUM_FARE = 1

  def initialize
    @journey = {:entry_station => nil, :exit_station => nil}
  end

  def start_journey(entry_station)
    @journey[:entry_station] = entry_station
    @entry_station = entry_station
  end

  def end_journey(exit_station = nil)
    @journey[:exit_station] = exit_station
    @exit_station = exit_station
  end

  def fare
    complete? ? MINIMUM_FARE : PENALTY
  end

  def complete?
    (!!@journey[:entry_station]) && (!!@journey[:exit_station])
  end

end
