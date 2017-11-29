require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:station) { double(:station) }

  before do |example|
    unless example.metadata[:skip_before]
      oystercard.top_up(Oystercard::DEFAULT_MINIMUM)
      oystercard.touch_in(station)
    end
  end

  describe "#initialize" do

    it "initializes with a balance of zero", :skip_before do
      expect(oystercard.balance).to be_zero
    end

    it "initializes with an empty array of journeys" do
      expect(oystercard.journeys).to eq []
    end

  end

  describe "#top_up" do

    it "adds a given amount to the card" do
      expect{ oystercard.top_up(10) }.to change {oystercard.balance}.by 10
    end

    it "raises an error if the default limit is reached", :skip_before do
      oystercard.top_up(Oystercard::DEFAULT_LIMIT)
      expect{ oystercard.top_up(1) }.to raise_error "You have reached a top up limit of £#{Oystercard::DEFAULT_LIMIT}"
    end

  end

  describe "#in_journey?" do
    it "checks if it is in journey" do
      expect(oystercard).to be_in_journey
    end
  end

  describe "#touch_in" do

      context "with top-up" do

        it "should be in_journey when touched in" do
          expect(oystercard).to be_in_journey
        end

        it "stores the start station in instance variable" do
          expect(oystercard.entry_station).to eq(station)
        end
      end

    it "raises an error when attempting to touch in with balance of < £#{Oystercard::DEFAULT_MINIMUM}", :skip_before do
      expect {oystercard.touch_in(station) }.to raise_error "Insufficient balance for journey"
    end


  end

  describe "#touch_out" do

    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
    end
     it "should not be in_journey when touched out" do
       expect(oystercard).to_not be_in_journey
     end

     it "deducts a given amount when touched out" do
       expect { oystercard.touch_out(station) }.to change{ oystercard.balance }.by(-Oystercard::DEFAULT_MINIMUM)
     end

     it "removes the entry station from the instance variable" do
       expect(oystercard.entry_station).to eq nil
     end

     it "stores the exit station in an instance variable" do
       expect(oystercard.exit_station).to eq(station)
     end
  end

  describe "#record_journey" do

    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      oystercard.touch_out(station)
    end
    it "adds the exit station to a journey hash" do
      expect(oystercard.journey).to include(:entry_station => station, :exit_station => station)
    end

    it "pushes the journey has into the journeys array" do
      expect(oystercard.journeys).to include(oystercard.journey)
    end

  end


end
