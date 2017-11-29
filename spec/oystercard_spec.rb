require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to :balance }

  let(:station) { double(:station) }

  describe "#initialize" do

    it "initializes with a balance of zero" do
      expect(subject.balance).to eq 0
    end

    it "initializes with an empty array of journeys" do
      expect(subject.journeys).to eq []
    end

  end

  describe "#top_up" do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "adds a given amount to the card" do
      expect{ subject.top_up(10) }.to change {subject.balance}.by 10
    end

    it "sets a limit to the deafult limit" do
      limit = Oystercard::DEFAULT_LIMIT
      subject.top_up(limit)
      expect{ subject.top_up(1) }.to raise_error "You have reached a top up limit of £#{limit}"
    end

    it "raises error if initial balance is not nil before top_up" do
      limit = Oystercard::DEFAULT_LIMIT
      subject.top_up(10)
      expect{ subject.top_up(limit) }.to raise_error "You have reached a top up limit of £#{limit}"
    end
  end

  describe "#in_journey?" do
    it "checks if it is initially not in journey" do
      expect(subject).not_to be_in_journey
    end
  end

  describe "#touch_in" do

      context "with top-up" do

        before do
          subject.top_up(Oystercard::DEFAULT_MINIMUM)
          subject.touch_in(station)
        end

        it "should be in_journey when touched in" do
          expect(subject).to be_in_journey
        end

        it "stores the start station in instance variable" do
          expect(subject.entry_station).to eq(station)
        end
      end

    it "raises an error when attempting to touch in with balance of < £#{Oystercard::DEFAULT_MINIMUM}" do
      expect {subject.touch_in(station) }.to raise_error "Insufficient balance for journey"
    end


  end

  describe "#touch_out" do

    before do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
    end
     it "should not be in_journey when touched out" do
       expect(subject).to_not be_in_journey
     end

     it "deducts a given amount when touched out" do
       expect { subject.touch_out(station) }.to change{ subject.balance }.by(-Oystercard::DEFAULT_MINIMUM)
     end

     it "removes the entry station from the instance variable" do
       expect(subject.entry_station).to eq nil
     end

     it "stores the exit station in an instance variable" do
       expect(subject.exit_station).to eq(station)
     end
  end

  describe "#record_journey" do

    before do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station)
    end
    it "adds the exit station to a journey hash" do
      expect(subject.journey).to include(:entry_station => station, :exit_station => station)
    end

    it "pushes the journey has into the journeys array" do
      expect(subject.journeys).to include(subject.journey)
    end

  end


end
