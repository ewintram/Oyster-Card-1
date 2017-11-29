require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys, :journey

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    raise "Insufficient balance for journey" if @balance < 1
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MINIMUM)
    @exit_station = exit_station
    record_journey
    @entry_station = nil
  end

  private

  def record_journey
    @journey = {:entry_station => @entry_station, :exit_station => @exit_station}
    @journeys << @journey
  end

  def deduct(money)
    @balance -= money
  end

end
