require 'journey'

describe Journey do

  let(:station) { double(:station) }
  let(:oystercard) { double(:oystercard) }

  context "given an entry station" do
    subject(:journey) { described_class.new }

    describe "#initialize" do
      it "logs entry station with a new journey" do
        expect(journey.journey).to eq({:entry_station => nil, :exit_station => nil})
      end

    describe "#start_journey" do
      it "logs entry_station station with a touching in of journey" do
        journey.start_journey(station)
        expect(journey.entry_station).to eq(station)
      end
    end

    describe "#end_journey" do
      it "logs exit_station with a touching out of journey" do
        journey.end_journey(station)
        expect(journey.exit_station).to eq(station)
      end
    end
  end

  context "#fare - given an entry_station" do
    subject(:journey) { described_class.new }
      it "calculates the minimum fare for a complete journey" do
        journey.start_journey(station)
        journey.end_journey(station)
        expect(journey.fare).to eq Journey::MINIMUM_FARE
      end

      it "calculates the penalty fare if there is no exit_station" do
        journey.end_journey(nil)
        expect(journey.fare).to eq Journey::PENALTY
      end
  end

  context "#fare - given an exit_station" do
    subject(:journey) { described_class.new }
    it "calculates the penalty fare if there is no entry_station" do
      journey.end_journey(station)
      expect(journey.fare).to eq Journey::PENALTY
    end
  end

  describe "#complete" do
    it "returns that a journey is complete" do
      journey.start_journey(station)
      journey.end_journey(station)
      expect(journey.complete?).to be true
    end

    it "returns that a journey is incomplete" do
      journey.end_journey(nil)
      expect(journey.complete?).to be false
    end

  end

  end
end
