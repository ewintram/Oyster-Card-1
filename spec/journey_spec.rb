require 'journey'

describe Journey do

  subject(:journey) { described_class.new('Stockwell') }
  let(:station) { double(:station) }
  let(:oystercard) { double(:oystercard) }



    # before do
    #   oystercard.touch_out(station)
    # end
  describe "#initialize" do
    it "logs entry station with a new journey" do
      expect(journey.entry_station).to eq('Stockwell')
    end

  describe "#end_journey" do
    it "logs exit station with a touching out of journey" do
      journey.end_journey('Hoxton')
      expect(journey.exit_station).to eq('Hoxton')
    end
  end

  describe "#record_journey" do
    it "records the journey" do
      journey.end_journey('Hoxton')
      expect(journey.record_journey).to eq({:entry_station => "Stockwell", :exit_station => "Hoxton"})
    end
  end

  describe "#fare" do
    it "calculates the fare" do
      journey.end_journey("Hoxton")
      expect(journey.fare).to eq Oystercard::DEFAULT_MINIMUM
    end

    it "calculates the fare" do
      journey.end_journey(nil)
      expect(journey.fare).to eq Oystercard::PENALTY
    end

  end


  end
end
