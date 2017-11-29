require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journey_history, :journey

  DEFAULT_LIMIT = 90
  DEFAULT_MINIMUM = 1
  PENALTY = 6

  def initialize
    @balance = 0
    @journey_history = []
    @entry_station = nil
  end

  def top_up(money)
    raise "You have reached a top up limit of £#{DEFAULT_LIMIT}" if  money + @balance > DEFAULT_LIMIT
    @balance += money
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    double_touch
    raise "Insufficient balance for journey" if @balance < 1
    @entry_station = entry_station
    @journey = Journey.new(@entry_station)
  end

  def touch_out(exit_station)
    deduct
    @exit_station = exit_station
    update_journey_history
    @entry_station = nil
  end

  private

  def update_journey_history
    @journey.end_journey(@exit_station)
    @journey_history << @journey.record_journey
  end

  def deduct
    @balance -= @journey.fare
  end

  def double_touch
    if !@entry_station.nil?
      update_journey_history
      deduct
    end
  end
end
