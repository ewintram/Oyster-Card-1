require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :journey_history, :journey

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1


  def initialize
    @balance = 0
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  def touch_in(entry_station)
    double_touch
    raise "Insufficient balance for journey" if @balance < 1
    @entry_station = entry_station
    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
    @journey.end_journey(exit_station)
    update_journey_history
    deduct
    @entry_station = nil
    @journey = Journey.new
  end

  private

  def update_journey_history
    @journey_history << @journey.journey
  end

  def deduct
    @balance -= @journey.fare
  end

  def double_touch
    if !@entry_station.nil?
      deduct
      @journey.end_journey
      update_journey_history
    end
  end
end
