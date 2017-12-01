class Journey

  attr_reader :entry_station, :exit_station

  PENALTY = 6
  MINIMUM_FARE = 1

   def initialize
     @entry_station = nil
     @exit_station = nil
   end

  def start_journey(entry_station)
    @entry_station = entry_station
  end

  def end_journey(exit_station = nil)
    @exit_station = exit_station
  end

  def fare
    self.complete? ? MINIMUM_FARE : PENALTY
  end

  def complete?
    !@entry_station.nil? && !@exit_station.nil?
  end

end
