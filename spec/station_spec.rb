require 'station'

describe Station do

  subject(:station) {described_class.new("Bank", 1)}

  describe "#initialize" do

    it "initializes with a name" do
      expect(station.station_name).to eq("Bank")
    end

    it "initializes with a zone" do
      expect(station.station_zone).to eq 1
    end
  end

end
